'use strict';

// Lightweight things to do before the page is displayed
// This should not rely on any JQuery or other libraries


// Hide the key fingerprints that we are not interested in
var sheet = document.styleSheets[0];
var fingerprint_hash;
if(localStorage && localStorage.getItem('preferred_fingerprint_hash') == 'SHA256') {
	sheet.insertRule('span.fingerprint_md5 {display:none}', 0)
} else {
	sheet.insertRule('span.fingerprint_sha256 {display:none}', 0)
}