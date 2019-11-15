# # OpenTracing::GlobalTracer

Get easy access to the OpenTracing Singleton

## SYNOPSIS


```perl
use OpenTracing::GlobalTracer qw/$my_glabal_tracer/;

```

and in the various part of the code:

```perl
my $span  = $my_glabal_tracer->get_active_span;

my $scope = $my_glabal_tracer->sart_active_span( $operation_name );
```

## DESCRIPTION

This module give easy access to the OpenTracing singleton.

During import, when `use`ing the module, it can take the name of a variable to
use in the current scope.

The modules provide two methods, `set_global_tracer` and `get_global_tracer`.

If none is set (or cleared), per definition, it will give back a 'NoOp'
implementation.
