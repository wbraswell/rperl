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
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator);
use RPerl::Operation::Expression::Operator;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm & elsewhere


# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(
    mongodb_get_database
    mongodb_get_collection
    mongodb_insert_one
    mongodb_find_one
);

# [[[ INCLUDES ]]]
use MongoDB;

#my MongoDB::Database $database = mongodb_get_database($client, $database_name);  # wrapped calling convention, procedural
sub mongodb_get_database {
    { my MongoDB::Database $RETURN_TYPE };
    ( my MongoDB::MongoClient $client, my string $database_name ) = @ARG;
    return $client->get_database($database_name);
}

#my MongoDB::Collection $collection = mongodb_get_collection($database, $collection_name);  # wrapped calling convention, procedural
sub mongodb_get_collection {
    { my MongoDB::Collection $RETURN_TYPE };
    ( my MongoDB::Database $database, my string $collection_name ) = @ARG;
    return $database->get_collection($collection_name);
}

#my MongoDB::InsertOneResult $collection->mongodb_insert_one({ name => 'rperl_test_data', ... });  # wrapped calling convention, procedural
sub mongodb_insert_one {
    { my MongoDB::InsertOneResult $RETURN_TYPE };
    ( my MongoDB::Collection $collection, my hashref $insert_data ) = @ARG;
    return $collection->insert_one($insert_data);
}

#my bson_document__optional $found_data = $collection->mongodb_find_one({ name => 'rperl_test_data' });  # wrapped calling convention, procedural
sub mongodb_find_one {
    { my bson_document__optional $RETURN_TYPE };
    ( my MongoDB::Collection $collection, my hashref $find_data ) = @ARG;
    return $collection->find_one($find_data);
}


# DEV NOTE, CORRELATION #rp132: disable OO wrapped calling convention for now, it is easier to implement procedural in C++

__DATA__

# [[[ PRE-DECLARED TYPES ]]]
#package    # hide from PAUSE indexing
#    MongoDB::Database::method;
#package    # hide from PAUSE indexing
#    MongoDB::Collection::method;
#package    # hide from PAUSE indexing
#    MongoDB::InsertOneResult::method;
#package    # hide from PAUSE indexing
#    hashref::method;



# [[[ SWITCH CONTEXT ]]]
package MongoDB::MongoClient;
use strict;
use warnings;
use RPerl::AfterSubclass;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(
    mongodb_get_database
);

# [[[ INCLUDES ]]]
# ...

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

#my MongoDB::Database $database = $client->mongodb_get_database($database_name);  # wrapped calling convention, OO
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

#my MongoDB::Collection $collection = $database->mongodb_get_collection($collection_name);  # wrapped calling convention, OO
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

#my MongoDB::InsertOneResult $collection->mongodb_insert_one({ name => 'rperl_test_data', ... });  # wrapped calling convention, OO
sub mongodb_insert_one {
    { my MongoDB::InsertOneResult::method $RETURN_TYPE };
    ( my MongoDB::Collection $self, my hashref $insert_data ) = @ARG;
    return $self->insert_one($insert_data);
}

#my bson_document__optional $found_data = $collection->mongodb_find_one({ name => 'rperl_test_data' });  # wrapped calling convention, OO
sub mongodb_find_one {
    { my bson_document__optional::method $RETURN_TYPE };
    ( my MongoDB::Collection $self, my hashref $find_data ) = @ARG;
    return $self->find_one($find_data);
}

1;    # end of class
