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
      result << %|<div class="error" id="popup_blocker_msg"><noscript>#{message}</noscript></div>|
      result << javascript_tag(%|
  var active = true;
  var w = window.open('','#{title}','width=100,height=100');
  if (null != w) {
    w.blur();
    active = w.closed;
    w.close();
  }
  if (active == true) {
    var msg_div = document.getElementById('popup_blocker_msg');
    msg_div.innerHTML = '#{message}';
  }
|)
      return result
    end
  end
end