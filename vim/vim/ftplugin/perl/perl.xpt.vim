XPTemplate priority=personal

XPT sub_ wrap=code wraponly
`name^(`args^);

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

XPT hash
%`name^ = (
    `key^ => `value^,
    `...^`key^ => `value^,
    `...^
);
