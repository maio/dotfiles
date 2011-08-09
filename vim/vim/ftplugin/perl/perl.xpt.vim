XPTemplate priority=personal

XPT sub_ wrap=code wraponly
`my var = {{^my `var^ = `}}^`name^(`args^);

sub `name^ {
    my (`args^) = @_;

    `code^
}

XPT method
sub `name^ {
    my ($self`...^`, `arg?^` `...^) = @_;
    `cursor^
}

XPT test
sub `name^ : Tests {
    my ($self) = @_;

    `cursor^
}

XPT spec
use Test::Spec;

`cursor^

runtests unless caller;

XPT describe
describe '`name^' => sub {
    `cursor^
};

XPT it
it '`does something^' => sub {
    `cursor^
};

XPT tester wrap=test
sub `name^ {
    my (`args^) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    `test^
}

XPT has
has '`attribute^' => (is => '`ro^');`cursor^

XPT class
package `Class^;
use Moose;

`cursor^

1;

XPT hash
%`name^ = (
    `key^ => `value^,
    `...^`key^ => `value^,
    `...^
);

XPT my
my (`vars^) = @_;
