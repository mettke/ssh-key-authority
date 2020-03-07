// Show only chosen fingerprint hash format in list views
$(function() {
    $('table th.fingerprint').first().each(function() {
        $(this).append(' ');
        var select = $('<select>');
        var options = ['MD5', 'SHA256'];
        for (var i = 0, option; option = options[i]; i++) {
            select.append($('<option>').text(option).val(option));
        }
        if (localStorage) {
            var fingerprint_hash = localStorage.getItem('preferred_fingerprint_hash');
            if (fingerprint_hash) {
                select.val(fingerprint_hash);
            }
        }
        $(this).append(select);
        select.on('change', function() {
            if (this.value == 'SHA256') {
                $('span.fingerprint_md5').hide();
                $('span.fingerprint_sha256').show();
            } else {
                $('span.fingerprint_sha256').hide();
                $('span.fingerprint_md5').show();
            }
            if (localStorage) {
                localStorage.setItem('preferred_fingerprint_hash', this.value);
            }
        });
    });
});

// Home page dynamic add pubkey form
$(function() {
    $('#add_key_button').on('click', function() {
        $('#help').hide().removeClass('hidden');
        $('#add_key_form').hide().removeClass('hidden');
        $('#add_key_form').show('fast');
        $('#add_key_button').hide();
        $('#add_public_key').focus();
    });
    $('#add_key_form button[type=button].btn-info').on('click', function() {
        $('#help').toggle('fast');
    });
    $('#add_key_form button[type=button].btn-default').on('click', function() {
        $('#add_key_form').hide('fast');
        $('#add_key_button').show();
    });
});