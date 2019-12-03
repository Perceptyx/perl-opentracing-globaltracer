requires                "OpenTracing::Implementation::NoOp::Tracer";

requires                "Carp";

on 'test' => sub {
    requires            "Test::Most";
};
