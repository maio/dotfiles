% Indentation tests

-module( erlang ).

-export(
	[ indent_simple/0
	, indent_anon/0
	, indent_case/0
	, indent_funcall/0
	] ).

indent_simple(  ) ->
	ok.

indent_anon(  ) ->
	_tmp = fun (  ) ->
		ok
	end.

indent_funcall(  ) ->
	_tmp = io:format(
		"hello"
	).

indent_case(  ) ->
	case somevalue of
		somevalue ->
			ok,
			fun (  ) ->
				fun (  ) ->
					ok
				end
			end;
		_ ->
			false
	end.
