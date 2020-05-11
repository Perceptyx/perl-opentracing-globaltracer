requires                "Carp";
requires                "Exporter";
requires                "Module::Load";
requires                "OpenTracing::Implementation::NoOp";


on 'develop' => sub {
    requires            "ExtUtils::MakeMaker::CPANfile";
};


on 'test' => sub {
    requires            "Test::Most";
};
