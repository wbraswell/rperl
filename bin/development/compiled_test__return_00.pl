#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.000_001;

# [[[ SETUP ]]]

## no critic qw(ProhibitParensWithBuiltins ProhibitNoisyQuotes)  ## RPERL SYSTEM allow PPI generated code

# return;  # PARSE ERROR: invalid RPerl, missing parenthesis
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless( { 'content' => ';' },      'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

# return();
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'finish' => bless(
                        { 'content' => ')' }, 'PPI::Token::Structure'
                    ),
                    'children' => [],
                    'start'    => bless(
                        { 'content' => '(' }, 'PPI::Token::Structure'
                    )
                },
                'PPI::Structure::List'
            ),
            bless( { 'content' => ';' }, 'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

# return 23;  # PARSE ERROR: invalid RPerl, missing parenthesis
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless( { 'content' => '23' },     'PPI::Token::Number' ),
            bless( { 'content' => ';' },      'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

# return(23);
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'finish' => bless(
                        { 'content' => ')' }, 'PPI::Token::Structure'
                    ),
                    'children' => [
                        bless(
                            {   'children' => [
                                    bless(
                                        { 'content' => '23' },
                                        'PPI::Token::Number'
                                    )
                                ]
                            },
                            'PPI::Statement::Expression'
                        )
                    ],
                    'start' => bless(
                        { 'content' => '(' }, 'PPI::Token::Structure'
                    )
                },
                'PPI::Structure::List'
            ),
            bless( { 'content' => ';' }, 'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

# return 23 + 12;  # PARSE ERROR: invalid RPerl, missing parenthesis
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless( { 'content' => '23' },     'PPI::Token::Number' ),
            bless( { 'content' => '+' },      'PPI::Token::Operator' ),
            bless( { 'content' => '12' },     'PPI::Token::Number' ),
            bless( { 'content' => ';' },      'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

# return(23) + 12;  # PARSE ERROR: invalid RPerl, missing parenthesis
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'finish' => bless(
                        { 'content' => ')' }, 'PPI::Token::Structure'
                    ),
                    'children' => [
                        bless(
                            {   'children' => [
                                    bless(
                                        { 'content' => '23' },
                                        'PPI::Token::Number'
                                    )
                                ]
                            },
                            'PPI::Statement::Expression'
                        )
                    ],
                    'start' => bless(
                        { 'content' => '(' }, 'PPI::Token::Structure'
                    )
                },
                'PPI::Structure::List'
            ),
            bless( { 'content' => '+' },  'PPI::Token::Operator' ),
            bless( { 'content' => '12' }, 'PPI::Token::Number' ),
            bless( { 'content' => ';' },  'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

# return(23 + 12);
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'finish' => bless(
                        { 'content' => ')' }, 'PPI::Token::Structure'
                    ),
                    'children' => [
                        bless(
                            {   'children' => [
                                    bless(
                                        { 'content' => '23' },
                                        'PPI::Token::Number'
                                    ),
                                    bless(
                                        { 'content' => '+' },
                                        'PPI::Token::Operator'
                                    ),
                                    bless(
                                        { 'content' => '12' },
                                        'PPI::Token::Number'
                                    )
                                ]
                            },
                            'PPI::Statement::Expression'
                        )
                    ],
                    'start' => bless(
                        { 'content' => '(' }, 'PPI::Token::Structure'
                    )
                },
                'PPI::Structure::List'
            ),
            bless( { 'content' => ';' }, 'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

#return 'foo';  # PARSE ERROR: invalid RPerl, missing parenthesis
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'separator' => '\'',
                    'content'   => '\'foo\''
                },
                'PPI::Token::Quote::Single'
            ),
            bless( { 'content' => ';' }, 'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

#return('foo');
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'finish' => bless(
                        { 'content' => ')' }, 'PPI::Token::Structure'
                    ),
                    'children' => [
                        bless(
                            {   'children' => [
                                    bless(
                                        {   'separator' => '\'',
                                            'content'   => '\'foo\''
                                        },
                                        'PPI::Token::Quote::Single'
                                    )
                                ]
                            },
                            'PPI::Statement::Expression'
                        )
                    ],
                    'start' => bless(
                        { 'content' => '(' }, 'PPI::Token::Structure'
                    )
                },
                'PPI::Structure::List'
            ),
            bless( { 'content' => ';' }, 'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

#return 'foo' . 'bar';  # PARSE ERROR: invalid RPerl, missing parenthesis
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'separator' => '\'',
                    'content'   => '\'foo\''
                },
                'PPI::Token::Quote::Single'
            ),
            bless( { 'content' => '.' }, 'PPI::Token::Operator' ),
            bless(
                {   'separator' => '\'',
                    'content'   => '\'bar\''
                },
                'PPI::Token::Quote::Single'
            ),
            bless( { 'content' => ';' }, 'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

#return('foo') . 'bar';  # PARSE ERROR: invalid RPerl, missing parenthesis
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'finish' => bless(
                        { 'content' => ')' }, 'PPI::Token::Structure'
                    ),
                    'children' => [
                        bless(
                            {   'children' => [
                                    bless(
                                        {   'separator' => '\'',
                                            'content'   => '\'foo\''
                                        },
                                        'PPI::Token::Quote::Single'
                                    )
                                ]
                            },
                            'PPI::Statement::Expression'
                        )
                    ],
                    'start' => bless(
                        { 'content' => '(' }, 'PPI::Token::Structure'
                    )
                },
                'PPI::Structure::List'
            ),
            bless( { 'content' => '.' }, 'PPI::Token::Operator' ),
            bless(
                {   'separator' => '\'',
                    'content'   => '\'bar\''
                },
                'PPI::Token::Quote::Single'
            ),
            bless( { 'content' => ';' }, 'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

#return('foo' . 'bar');
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'finish' => bless(
                        { 'content' => ')' }, 'PPI::Token::Structure'
                    ),
                    'children' => [
                        bless(
                            {   'children' => [
                                    bless(
                                        {   'separator' => '\'',
                                            'content'   => '\'foo\''
                                        },
                                        'PPI::Token::Quote::Single'
                                    ),
                                    bless(
                                        { 'content' => '.' },
                                        'PPI::Token::Operator'
                                    ),
                                    bless(
                                        {   'separator' => '\'',
                                            'content'   => '\'bar\''
                                        },
                                        'PPI::Token::Quote::Single'
                                    )
                                ]
                            },
                            'PPI::Statement::Expression'
                        )
                    ],
                    'start' => bless(
                        { 'content' => '(' }, 'PPI::Token::Structure'
                    )
                },
                'PPI::Structure::List'
            ),
            bless( { 'content' => ';' }, 'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);

#return(23, 'foo');
bless(
    {   'children' => [
            bless( { 'content' => 'return' }, 'PPI::Token::Word' ),
            bless(
                {   'finish' => bless(
                        { 'content' => ')' }, 'PPI::Token::Structure'
                    ),
                    'children' => [
                        bless(
                            {   'children' => [
                                    bless(
                                        { 'content' => '23' },
                                        'PPI::Token::Number'
                                    ),
                                    bless(
                                        { 'content' => ',' },
                                        'PPI::Token::Operator'
                                    ),
                                    bless(
                                        {   'separator' => '\'',
                                            'content'   => '\'foo\''
                                        },
                                        'PPI::Token::Quote::Single'
                                    )
                                ]
                            },
                            'PPI::Statement::Expression'
                        )
                    ],
                    'start' => bless(
                        { 'content' => '(' }, 'PPI::Token::Structure'
                    )
                },
                'PPI::Structure::List'
            ),
            bless( { 'content' => ';' }, 'PPI::Token::Structure' )
        ]
    },
    'PPI::Statement::Break'
);
