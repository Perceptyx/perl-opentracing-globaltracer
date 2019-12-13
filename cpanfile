on 'runtime' => sub {
    requires            "OpenTracing::Implementation::NoOp::Tracer";
};

requires                "Carp";
requires                "Module::Load";

on 'test' => sub {
    requires            "Test::Most";
};
