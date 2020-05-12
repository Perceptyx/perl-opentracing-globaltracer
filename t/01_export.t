use Test::Most;

use strict;
use warnings;

use constant TRACER_CLASS => 'OpenTracing::Implementation::NoOp::Tracer';

use OpenTracing::GlobalTracer qw/get_global_tracer/;

OpenTracing::GlobalTracer->set_global_tracer(TRACER_CLASS->new);

isa_ok $TRACER, TRACER_CLASS, 'tracer from default $TRACER variable'
  or diag explain $TRACER;

my $tracer = OpenTracing::GlobalTracer->get_global_tracer();
isa_ok $tracer, TRACER_CLASS, 'get_global_tracer as a class method'
  or diag explain $tracer;

$tracer = get_global_tracer();
isa_ok $tracer, TRACER_CLASS, 'get_global_tracer as a function'
  or diag explain $tracer;

{
  package Renamed;
  use OpenTracing::GlobalTracer '$MY_TRACER';
}

isa_ok $Renamed::MY_TRACER, TRACER_CLASS, 'tracer from user-specified variable'
  or diag explain $Renamed::MY_TRACER;

done_testing();
