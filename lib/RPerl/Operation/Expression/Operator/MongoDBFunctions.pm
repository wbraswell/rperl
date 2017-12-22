# START HERE: create C++ wrappers, compile!
# START HERE: create C++ wrappers, compile!
# START HERE: create C++ wrappers, compile!

# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::MongoDBFunctions;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator);
use RPerl::Operation::Expression::Operator;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm & elsewhere

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    MongoDB::Database::method;
package    # hide from PAUSE indexing
    MongoDB::Collection::method;
package    # hide from PAUSE indexing
    MongoDB::InsertOneResult::method;
package    # hide from PAUSE indexing
    hashref::method;

# [[[ INCLUDES ]]]
use MongoDB;



# [[[ SWITCH CONTEXT ]]]
package MongoDB::MongoClient;
use strict;
use warnings;
use RPerl::AfterSubclass;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(
    mongodb_new
    mongodb_get_database
);

# [[[ INCLUDES ]]]
# ...

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

#my MongoDB::MongoClient $my_client = mongodb_new({host => 'localhost', port => 27_017});
sub mongodb_new {
    { my MongoDB::MongoClient $RETURN_TYPE };
    return MongoDB::MongoClient->new(@ARG);
}

#my MongoDB::Database $database = $client->mongodb_get_database($database_name);  # wrapped calling convention
sub mongodb_get_database {
    { my MongoDB::Database::method $RETURN_TYPE };
    ( my MongoDB::MongoClient $self, my string $database_name ) = @ARG;
    return $self->get_database($database_name);
}


# [[[ SWITCH CONTEXT ]]]
package MongoDB::Database;
use strict;
use warnings;
use RPerl::AfterSubclass;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(
    mongodb_get_collection
);

# [[[ INCLUDES ]]]
# ...

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

#my MongoDB::Collection $collection = $database->mongodb_get_collection($collection_name);  # wrapped calling convention
sub mongodb_get_collection {
    { my MongoDB::Collection::method $RETURN_TYPE };
    ( my MongoDB::Database $self, my string $collection_name ) = @ARG;
    return $self->get_collection($collection_name);
}



# [[[ SWITCH CONTEXT ]]]
package MongoDB::Collection;
use strict;
use warnings;
use RPerl::AfterSubclass;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(
    mongodb_insert_one
    mongodb_find_one
);

# [[[ INCLUDES ]]]
# ...

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

#my MongoDB::InsertOneResult $collection->mongodb_insert_one({ name => 'rperl_test_data', ... });  # wrapped calling convention
sub mongodb_insert_one {
    { my MongoDB::InsertOneResult::method $RETURN_TYPE };
    ( my MongoDB::Collection $self, my hashref $insert_data ) = @ARG;
    return $self->insert_one($insert_data);
}

#my hashref $found_data = $collection->mongodb_find_one({ name => 'rperl_test_data' });  # wrapped calling convention
sub mongodb_find_one {
    { my hashref::method $RETURN_TYPE };
    ( my MongoDB::Collection $self, my hashref $find_data ) = @ARG;
    return $self->find_one($find_data);
}

1;    # end of class
