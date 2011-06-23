XPTemplate priority=personal

XPT extract wrap=code " tips here
`name^(...);

sub `name^ {
    `code^
}

XPT method
sub `name^ {
    my ($self`...^`, `arg?^`...^) = @_;
    `cursor^
}
