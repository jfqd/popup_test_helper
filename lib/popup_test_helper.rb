# = PopupTestHelper
#
# The PopupTestHelper method create HTML and Javascript code to test if popups are blocked by the browser.
# You might need it for dealing with 3D-Secure credit card verification.
#
# Created by: Stefan Husch (free2b AT blun DOT org), 2009-11-13
# 
# Code could be found on Github: http://github.com/jfqd/popup_test_helper
# 
# == Options
#
# <%= popup_test_helper(message) -%>
#
#   message: message which will be inserted if popups are not allowed
#   nojsmsg: message rendered if Javascript is turned off

module ActionView::Helpers
  module PopupTestHelper
    def popup_test_helper(message=nil, nojsmsg=nil, result='')
      message = message || 'Popups need to be allowed for 3D-Secure verification of your credit card!'
      nojsmsg = nojsmsg || 'Popups and JavaScript need to be allowed for 3D-Secure verification of your credit card!'
      result << %(<div class='popup_blocker_msg' id='popup_blocker_msg'><noscript>#{nojsmsg}</noscript></div>)
      result << javascript_tag(%*
try {
  var active = true;
  var elem = document.getElementById('popup_blocker_msg');
  var win = null;
  wind = window.open('','','width=100,height=100');
  if (null != wind) {
    wind.blur();
    active = wind.closed;
    wind.close();
  }
  if (active == true) {
    elem.innerHTML = '#{message}';
  } else {
    elem.parentNode.removeChild(elem);
  }
} catch(err) {alert('#{message}');}
      *)
      return result
    end
  end
end