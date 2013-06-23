package types;
use strict; use warnings;

# all lists lowest-to-highest level

# [[[ DATA TYPES ]]]
use RPerl::DataType::Void;
use RPerl::DataType::Integer;
use RPerl::DataType::Float;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
use RPerl::DataType::Scalar;
use RPerl::DataType::Unknown;

# [[[ DATA STRUCTURES ]]]
use RPerl::DataStructure::Array;
use RPerl::DataStructure::Hash;
use RPerl::DataStructure::LinkedList;
use RPerl::DataStructure::LinkedList::Node;
use RPerl::DataStructure::Graph;
use RPerl::DataStructure::Graph::Tree;
use RPerl::DataStructure::Graph::Tree::Binary;
use RPerl::DataStructure::Graph::Tree::Binary::Node;

# [[[ CODE ]]]
use RPerl::Code::Subroutine;

# [[[ OBJECT-ORIENTED ]]]
use RPerl::Class;
use RPerl::Object;
use RPerl::DataStructure::Property;
use RPerl::Code::Subroutine::Method;

1;
