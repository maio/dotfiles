XPTemplate priority=personal

XPT test " function test..() {..}
function test`Name^()`$BRfun^{
    `cursor^
}

XPT fun " function ..( .. ) {..}
XSET params=Void()
function `funName^(`params^)`$BRfun^{
    `cursor^
}

XPT class " class .. { .. }
class `className^`$BRfun^{
    function __construct(`args^)`$BRfun^{
        `cursor^
    }
}

XPT service " class .. { .. }
use Albumino\Php\Callable;

class `ClassName^ extends Callable {
    function call(`args^) {
        `cursor^
    }
}

XPT construct " construct
function __construct(`args^)`$BRfun^{
    `cursor^
}

XPT try wrap=risky " try
try {
    `risky^
}
catch (`Exception^ `var^) {
    `handle^
}
