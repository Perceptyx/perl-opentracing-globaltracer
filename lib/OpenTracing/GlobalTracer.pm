package OpenTracing::GlobalTracer;

use strict;
use warnings;

use OpenTracing::Implementation::NoOp::Tracer;

use Carp;

my $TRACER;



sub import {
    my $class = shift;
    
    croak "OpenTracing::GlobalTracer has too many parameters when loading"
        if @_ > 1;
    
    my $injected_variable = shift // '$TRACER';
    # Normally we'd expect the caller to provide a variable name - but if they
    # don't, `$tracer` seems as good a default as any
    
    my ($bare_name) = $injected_variable =~ /^\$(\w+)$/
        or croak "invalid injected variable name [$injected_variable]";
    
    my ($package_name) = caller;
    my $fully_qualified_name = $package_name . '::' . $bare_name;
    {
        no strict 'refs';
        
        # This mostly does what we'd want if we're called at compiletime before
        # any code actually tries to use the injected variable - but as soon as
        # the compiler sees $SomeModule::tracer it'll happily tell the symbol
        # table about it and trigger this check. Thus, it's currently disabled,
        # and since Log::Any also skips the check it seems we're in good
        # company.
        #
        # require B;
        # croak "$package_name already has a variable called:$injected_variable"
        #    if B::svref_2object(\*$fully_qualified_name)->SV->$*;
        *$fully_qualified_name = \$TRACER;
    }
    
    carp "$fully_qualified_name installed"
        if $ENV{OPENTRACING_DEBUG};
    
    return
}



sub set_global_tracer {
    my $class = shift;
    my $tracer = shift;
    
    carp "Overwriting existing GlobalTracer"
        if $ENV{OPENTRACING_DEBUG};
    carp "GlobalTracer is cleared."
        if $ENV{OPENTRACING_DEBUG} and not defined $tracer;
    
    $TRACER = $tracer;
    
    return
}



sub get_global_tracer {
    
    return $TRACER
        if defined $TRACER;
    
    carp "GlobalTracer is using defaulted 'NoOp' implementation"
        if $ENV{OPENTRACING_DEBUG};
    
    return OpenTracing::Implementation::NoOp::Tracer->new( )
}



sub is_registered { defined $TRACER }



1;
