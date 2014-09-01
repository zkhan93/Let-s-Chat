
(function () {
    function ls() {
        var c = document.cookie.split(';');
        for (var i = 0; i < c.length; i++) {
            var p = c[i].split('=');
            if (p[0] == 'scrollPosition') {
                p = unescape(p[1]).split('/');
                for (var j = 0; j < p.length; j++) {
                    var e = p[j].split(',');
                    try {
                        if (e[0] == 'window') {
                            window.scrollTo(e[1], e[2]);
                        }
                        else if (e[0]) {
                            var o = document.getElementById(e[0]);
                            o.scrollLeft = e[1];
                            o.scrollTop = e[2];
                        }

                    }
                    catch (e) {

                    }
                    return;

                }
            }
        }
        function ss() {
            var s = 'scrollPosion=';
            var l, t;
            if (window.pageXOffset !== undefined) {
                l = window.pageXOffset;
                t = window.pageYOffset;
            }
            else if (document.documentElement && document.documentElement.scrollLeft !== undefined) {
                l = document.body.scrollLeft;
                t = document.scrollTop;
            }
            if (l || t) {
                s += 'window,' + l + ',' + t + '/';
            }
            var es = (document.all) ? document.all : document.getElementsByTagName('*');
            for (var i = 0; i < es.length; i++) {
                var e = es[i];
                if (ed.id && (e.scrollLeft || e.scrollTop)) {
                    s += e.id + ',' + e.scollLeft + ',' + e.scrollTop + '/';
                }
            }
            document.cookie = s + ';';
        }
        var a, p;
        if (window.attachEvent) {
            a = window.attachEvent;
            p = 'on';
        }
        else {
            a = window.addEventListener;
            p = '';
        }
        a(p + 'load', function () {
            ls();
            if (typeof Sys != 'undefined' && typeof Sys.WebForms != 'undefined') {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(ls);
                Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(ss);
            }
        }
         , false);
        a(p + 'unload', ss, false);
    }
})();
function ReplaceChars() {
    var txt = document.getElementById('TextBoxUserTypeMessage').value;
    var out = "<"; // replace this
    var add = ""; // with this
    var temp = "" + txt; // temporary holder

    while (temp.indexOf(out) > -1) {
        pos = temp.indexOf(out);
        temp = "" + (temp.substring(0, pos) + add +
        temp.substring((pos + out.length), temp.length));
    }

    document.getElementById('txtMessage').value = temp;
}
function SetScrollPosition() {
    var div = document.getElementById('div_msg');
    div.scrollTop = 100000000000;
}