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
# <%= popup_test_helper(message, title) -%>
#
#   message: message which will be inserted if popups are not allowed
#   title:   title of the popup window

module ActionView::Helpers
  module PopupTestHelper
    def popup_test_helper(message=nil, title=nil, result='')
      message = message || 'Popups need to be allowed for 3D-Secure verification!'
      title = title || 'Popup blocker test for 3D-Secure verification'
      result << %|<div class='popup_blocker_msg' id='popup_blocker_msg'><noscript>#{message}</noscript></div>|
      result << javascript_tag(%|
  var active = true;
  var title = '#{message}';
  if (isIE() == true) { title = ''; }
  var elem = document.getElementById('popup_blocker_msg');
  var wind = window.open('',title,'width=100,height=100');
  if (null != wind) {
    wind.blur();
    active = wind.closed;
    wind.close();
  }
  if (active == true) {
    elem.innerHTML = '#{message}';
  } else {
    elem.parentNode.removeChild(div);
  }
  function isIE() {
    return /msie/i.test(navigator.userAgent) && !/opera/i.test(navigator.userAgent);
  }
|)
      return result
    end
  end
end