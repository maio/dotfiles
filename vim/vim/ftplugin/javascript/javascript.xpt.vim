XPTemplate priority=personal

XPT function_ wrap=code wraponly
`var variable = {{^var `variable^ = `}}^`name^(`args^);

function `name^(`args^) {
    `code^
}

XPT function
function `name^(`args^) {
    `cursor^
}

XPT describe
describe("`name^", function () {
    `cursor^
});

XPT it
it("`does something^", function () {
    `cursor^
});

