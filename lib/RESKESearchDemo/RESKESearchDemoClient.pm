package RESKESearchDemo::RESKESearchDemoClient;

use JSON::RPC::Client;
use POSIX;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;
my $get_time = sub { time, 0 };
eval {
    require Time::HiRes;
    $get_time = sub { Time::HiRes::gettimeofday() };
};

use Bio::KBase::AuthToken;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

RESKESearchDemo::RESKESearchDemoClient

=head1 DESCRIPTION


A KBase module: RESKESearchDemo


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => RESKESearchDemo::RESKESearchDemoClient::RpcClient->new,
	url => $url,
	headers => [],
    };

    chomp($self->{hostname} = `hostname`);
    $self->{hostname} ||= 'unknown-host';

    #
    # Set up for propagating KBRPC_TAG and KBRPC_METADATA environment variables through
    # to invoked services. If these values are not set, we create a new tag
    # and a metadata field with basic information about the invoking script.
    #
    if ($ENV{KBRPC_TAG})
    {
	$self->{kbrpc_tag} = $ENV{KBRPC_TAG};
    }
    else
    {
	my ($t, $us) = &$get_time();
	$us = sprintf("%06d", $us);
	my $ts = strftime("%Y-%m-%dT%H:%M:%S.${us}Z", gmtime $t);
	$self->{kbrpc_tag} = "C:$0:$self->{hostname}:$$:$ts";
    }
    push(@{$self->{headers}}, 'Kbrpc-Tag', $self->{kbrpc_tag});

    if ($ENV{KBRPC_METADATA})
    {
	$self->{kbrpc_metadata} = $ENV{KBRPC_METADATA};
	push(@{$self->{headers}}, 'Kbrpc-Metadata', $self->{kbrpc_metadata});
    }

    if ($ENV{KBRPC_ERROR_DEST})
    {
	$self->{kbrpc_error_dest} = $ENV{KBRPC_ERROR_DEST};
	push(@{$self->{headers}}, 'Kbrpc-Errordest', $self->{kbrpc_error_dest});
    }

    #
    # This module requires authentication.
    #
    # We create an auth token, passing through the arguments that we were (hopefully) given.

    {
	my %arg_hash2 = @args;
	if (exists $arg_hash2{"token"}) {
	    $self->{token} = $arg_hash2{"token"};
	} elsif (exists $arg_hash2{"user_id"}) {
	    my $token = Bio::KBase::AuthToken->new(@args);
	    if (!$token->error_message) {
	        $self->{token} = $token->token;
	    }
	}
	
	if (exists $self->{token})
	{
	    $self->{client}->{token} = $self->{token};
	}
    }

    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 add_workspace_to_index

  $obj->add_workspace_to_index($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a RESKESearchDemo.AddWorkspaceToIndexInput
AddWorkspaceToIndexInput is a reference to a hash where the following keys are defined:
	ws_name has a value which is a string
	ws_id has a value which is an int

</pre>

=end html

=begin text

$params is a RESKESearchDemo.AddWorkspaceToIndexInput
AddWorkspaceToIndexInput is a reference to a hash where the following keys are defined:
	ws_name has a value which is a string
	ws_id has a value which is an int


=end text

=item Description

This operation means that given workspace will be shared with
system indexing user with write access. User calling this
function should be owner of this workspace.

=back

=cut

 sub add_workspace_to_index
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function add_workspace_to_index (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to add_workspace_to_index:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'add_workspace_to_index');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "RESKESearchDemo.add_workspace_to_index",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'add_workspace_to_index',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return;
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method add_workspace_to_index",
					    status_line => $self->{client}->status_line,
					    method_name => 'add_workspace_to_index',
				       );
    }
}
 


=head2 search_types

  $return = $obj->search_types($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a RESKESearchDemo.SearchTypesInput
$return is a RESKESearchDemo.SearchTypesOutput
SearchTypesInput is a reference to a hash where the following keys are defined:
	match_filter has a value which is a RESKESearchDemo.MatchFilter
	access_filter has a value which is a RESKESearchDemo.AccessFilter
MatchFilter is a reference to a hash where the following keys are defined:
	full_text_in_all has a value which is a string
	access_group_id has a value which is an int
	object_name has a value which is a string
	parent_guid has a value which is a RESKESearchDemo.GUID
	timestamp has a value which is a RESKESearchDemo.MatchValue
	lookupInKeys has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.MatchValue
GUID is a string
MatchValue is a reference to a hash where the following keys are defined:
	value has a value which is a string
	int_value has a value which is an int
	double_value has a value which is a float
	bool_value has a value which is a RESKESearchDemo.boolean
	min_int has a value which is an int
	max_int has a value which is an int
	min_date has a value which is an int
	max_date has a value which is an int
	min_double has a value which is a float
	max_double has a value which is a float
boolean is an int
AccessFilter is a reference to a hash where the following keys are defined:
	with_private has a value which is a RESKESearchDemo.boolean
	with_public has a value which is a RESKESearchDemo.boolean
	with_all_history has a value which is a RESKESearchDemo.boolean
SearchTypesOutput is a reference to a hash where the following keys are defined:
	type_to_count has a value which is a reference to a hash where the key is a string and the value is an int
	search_time has a value which is an int

</pre>

=end html

=begin text

$params is a RESKESearchDemo.SearchTypesInput
$return is a RESKESearchDemo.SearchTypesOutput
SearchTypesInput is a reference to a hash where the following keys are defined:
	match_filter has a value which is a RESKESearchDemo.MatchFilter
	access_filter has a value which is a RESKESearchDemo.AccessFilter
MatchFilter is a reference to a hash where the following keys are defined:
	full_text_in_all has a value which is a string
	access_group_id has a value which is an int
	object_name has a value which is a string
	parent_guid has a value which is a RESKESearchDemo.GUID
	timestamp has a value which is a RESKESearchDemo.MatchValue
	lookupInKeys has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.MatchValue
GUID is a string
MatchValue is a reference to a hash where the following keys are defined:
	value has a value which is a string
	int_value has a value which is an int
	double_value has a value which is a float
	bool_value has a value which is a RESKESearchDemo.boolean
	min_int has a value which is an int
	max_int has a value which is an int
	min_date has a value which is an int
	max_date has a value which is an int
	min_double has a value which is a float
	max_double has a value which is a float
boolean is an int
AccessFilter is a reference to a hash where the following keys are defined:
	with_private has a value which is a RESKESearchDemo.boolean
	with_public has a value which is a RESKESearchDemo.boolean
	with_all_history has a value which is a RESKESearchDemo.boolean
SearchTypesOutput is a reference to a hash where the following keys are defined:
	type_to_count has a value which is a reference to a hash where the key is a string and the value is an int
	search_time has a value which is an int


=end text

=item Description



=back

=cut

 sub search_types
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function search_types (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to search_types:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'search_types');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "RESKESearchDemo.search_types",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'search_types',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method search_types",
					    status_line => $self->{client}->status_line,
					    method_name => 'search_types',
				       );
    }
}
 


=head2 search_objects

  $return = $obj->search_objects($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a RESKESearchDemo.SearchObjectsInput
$return is a RESKESearchDemo.SearchObjectsOutput
SearchObjectsInput is a reference to a hash where the following keys are defined:
	object_type has a value which is a string
	match_filter has a value which is a RESKESearchDemo.MatchFilter
	sorting_rules has a value which is a reference to a list where each element is a RESKESearchDemo.SortingRule
	access_filter has a value which is a RESKESearchDemo.AccessFilter
	pagination has a value which is a RESKESearchDemo.Pagination
	post_processing has a value which is a RESKESearchDemo.PostProcessing
MatchFilter is a reference to a hash where the following keys are defined:
	full_text_in_all has a value which is a string
	access_group_id has a value which is an int
	object_name has a value which is a string
	parent_guid has a value which is a RESKESearchDemo.GUID
	timestamp has a value which is a RESKESearchDemo.MatchValue
	lookupInKeys has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.MatchValue
GUID is a string
MatchValue is a reference to a hash where the following keys are defined:
	value has a value which is a string
	int_value has a value which is an int
	double_value has a value which is a float
	bool_value has a value which is a RESKESearchDemo.boolean
	min_int has a value which is an int
	max_int has a value which is an int
	min_date has a value which is an int
	max_date has a value which is an int
	min_double has a value which is a float
	max_double has a value which is a float
boolean is an int
SortingRule is a reference to a hash where the following keys are defined:
	is_timestamp has a value which is a RESKESearchDemo.boolean
	is_object_name has a value which is a RESKESearchDemo.boolean
	key_name has a value which is a string
	descending has a value which is a RESKESearchDemo.boolean
AccessFilter is a reference to a hash where the following keys are defined:
	with_private has a value which is a RESKESearchDemo.boolean
	with_public has a value which is a RESKESearchDemo.boolean
	with_all_history has a value which is a RESKESearchDemo.boolean
Pagination is a reference to a hash where the following keys are defined:
	start has a value which is an int
	count has a value which is an int
PostProcessing is a reference to a hash where the following keys are defined:
	ids_only has a value which is a RESKESearchDemo.boolean
	skip_info has a value which is a RESKESearchDemo.boolean
	skip_keys has a value which is a RESKESearchDemo.boolean
	skip_data has a value which is a RESKESearchDemo.boolean
	data_includes has a value which is a reference to a list where each element is a string
SearchObjectsOutput is a reference to a hash where the following keys are defined:
	pagination has a value which is a RESKESearchDemo.Pagination
	sorting_rules has a value which is a reference to a list where each element is a RESKESearchDemo.SortingRule
	objects has a value which is a reference to a list where each element is a RESKESearchDemo.ObjectData
	total has a value which is an int
	search_time has a value which is an int
ObjectData is a reference to a hash where the following keys are defined:
	guid has a value which is a RESKESearchDemo.GUID
	parent_guid has a value which is a RESKESearchDemo.GUID
	object_name has a value which is a string
	timestamp has a value which is an int
	parent_data has a value which is an UnspecifiedObject, which can hold any non-null object
	data has a value which is an UnspecifiedObject, which can hold any non-null object
	key_props has a value which is a reference to a hash where the key is a string and the value is a string

</pre>

=end html

=begin text

$params is a RESKESearchDemo.SearchObjectsInput
$return is a RESKESearchDemo.SearchObjectsOutput
SearchObjectsInput is a reference to a hash where the following keys are defined:
	object_type has a value which is a string
	match_filter has a value which is a RESKESearchDemo.MatchFilter
	sorting_rules has a value which is a reference to a list where each element is a RESKESearchDemo.SortingRule
	access_filter has a value which is a RESKESearchDemo.AccessFilter
	pagination has a value which is a RESKESearchDemo.Pagination
	post_processing has a value which is a RESKESearchDemo.PostProcessing
MatchFilter is a reference to a hash where the following keys are defined:
	full_text_in_all has a value which is a string
	access_group_id has a value which is an int
	object_name has a value which is a string
	parent_guid has a value which is a RESKESearchDemo.GUID
	timestamp has a value which is a RESKESearchDemo.MatchValue
	lookupInKeys has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.MatchValue
GUID is a string
MatchValue is a reference to a hash where the following keys are defined:
	value has a value which is a string
	int_value has a value which is an int
	double_value has a value which is a float
	bool_value has a value which is a RESKESearchDemo.boolean
	min_int has a value which is an int
	max_int has a value which is an int
	min_date has a value which is an int
	max_date has a value which is an int
	min_double has a value which is a float
	max_double has a value which is a float
boolean is an int
SortingRule is a reference to a hash where the following keys are defined:
	is_timestamp has a value which is a RESKESearchDemo.boolean
	is_object_name has a value which is a RESKESearchDemo.boolean
	key_name has a value which is a string
	descending has a value which is a RESKESearchDemo.boolean
AccessFilter is a reference to a hash where the following keys are defined:
	with_private has a value which is a RESKESearchDemo.boolean
	with_public has a value which is a RESKESearchDemo.boolean
	with_all_history has a value which is a RESKESearchDemo.boolean
Pagination is a reference to a hash where the following keys are defined:
	start has a value which is an int
	count has a value which is an int
PostProcessing is a reference to a hash where the following keys are defined:
	ids_only has a value which is a RESKESearchDemo.boolean
	skip_info has a value which is a RESKESearchDemo.boolean
	skip_keys has a value which is a RESKESearchDemo.boolean
	skip_data has a value which is a RESKESearchDemo.boolean
	data_includes has a value which is a reference to a list where each element is a string
SearchObjectsOutput is a reference to a hash where the following keys are defined:
	pagination has a value which is a RESKESearchDemo.Pagination
	sorting_rules has a value which is a reference to a list where each element is a RESKESearchDemo.SortingRule
	objects has a value which is a reference to a list where each element is a RESKESearchDemo.ObjectData
	total has a value which is an int
	search_time has a value which is an int
ObjectData is a reference to a hash where the following keys are defined:
	guid has a value which is a RESKESearchDemo.GUID
	parent_guid has a value which is a RESKESearchDemo.GUID
	object_name has a value which is a string
	timestamp has a value which is an int
	parent_data has a value which is an UnspecifiedObject, which can hold any non-null object
	data has a value which is an UnspecifiedObject, which can hold any non-null object
	key_props has a value which is a reference to a hash where the key is a string and the value is a string


=end text

=item Description



=back

=cut

 sub search_objects
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function search_objects (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to search_objects:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'search_objects');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "RESKESearchDemo.search_objects",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'search_objects',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method search_objects",
					    status_line => $self->{client}->status_line,
					    method_name => 'search_objects',
				       );
    }
}
 


=head2 get_objects

  $return = $obj->get_objects($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a RESKESearchDemo.GetObjectsInput
$return is a RESKESearchDemo.GetObjectsOutput
GetObjectsInput is a reference to a hash where the following keys are defined:
	guids has a value which is a reference to a list where each element is a RESKESearchDemo.GUID
	post_processing has a value which is a RESKESearchDemo.PostProcessing
GUID is a string
PostProcessing is a reference to a hash where the following keys are defined:
	ids_only has a value which is a RESKESearchDemo.boolean
	skip_info has a value which is a RESKESearchDemo.boolean
	skip_keys has a value which is a RESKESearchDemo.boolean
	skip_data has a value which is a RESKESearchDemo.boolean
	data_includes has a value which is a reference to a list where each element is a string
boolean is an int
GetObjectsOutput is a reference to a hash where the following keys are defined:
	objects has a value which is a reference to a list where each element is a RESKESearchDemo.ObjectData
	search_time has a value which is an int
ObjectData is a reference to a hash where the following keys are defined:
	guid has a value which is a RESKESearchDemo.GUID
	parent_guid has a value which is a RESKESearchDemo.GUID
	object_name has a value which is a string
	timestamp has a value which is an int
	parent_data has a value which is an UnspecifiedObject, which can hold any non-null object
	data has a value which is an UnspecifiedObject, which can hold any non-null object
	key_props has a value which is a reference to a hash where the key is a string and the value is a string

</pre>

=end html

=begin text

$params is a RESKESearchDemo.GetObjectsInput
$return is a RESKESearchDemo.GetObjectsOutput
GetObjectsInput is a reference to a hash where the following keys are defined:
	guids has a value which is a reference to a list where each element is a RESKESearchDemo.GUID
	post_processing has a value which is a RESKESearchDemo.PostProcessing
GUID is a string
PostProcessing is a reference to a hash where the following keys are defined:
	ids_only has a value which is a RESKESearchDemo.boolean
	skip_info has a value which is a RESKESearchDemo.boolean
	skip_keys has a value which is a RESKESearchDemo.boolean
	skip_data has a value which is a RESKESearchDemo.boolean
	data_includes has a value which is a reference to a list where each element is a string
boolean is an int
GetObjectsOutput is a reference to a hash where the following keys are defined:
	objects has a value which is a reference to a list where each element is a RESKESearchDemo.ObjectData
	search_time has a value which is an int
ObjectData is a reference to a hash where the following keys are defined:
	guid has a value which is a RESKESearchDemo.GUID
	parent_guid has a value which is a RESKESearchDemo.GUID
	object_name has a value which is a string
	timestamp has a value which is an int
	parent_data has a value which is an UnspecifiedObject, which can hold any non-null object
	data has a value which is an UnspecifiedObject, which can hold any non-null object
	key_props has a value which is a reference to a hash where the key is a string and the value is a string


=end text

=item Description



=back

=cut

 sub get_objects
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_objects (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_objects:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_objects');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "RESKESearchDemo.get_objects",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_objects',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_objects",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_objects',
				       );
    }
}
 


=head2 list_types

  $return = $obj->list_types($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a RESKESearchDemo.ListTypesInput
$return is a RESKESearchDemo.ListTypesOutput
ListTypesInput is a reference to a hash where the following keys are defined:
	type_name has a value which is a string
ListTypesOutput is a reference to a hash where the following keys are defined:
	types has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.TypeDescriptor
TypeDescriptor is a reference to a hash where the following keys are defined:
	type_name has a value which is a string
	type_ui_title has a value which is a string
	keys has a value which is a reference to a list where each element is a RESKESearchDemo.KeyDescription
KeyDescription is a reference to a hash where the following keys are defined:
	key_name has a value which is a string
	key_ui_title has a value which is a string
	key_value_type has a value which is a string

</pre>

=end html

=begin text

$params is a RESKESearchDemo.ListTypesInput
$return is a RESKESearchDemo.ListTypesOutput
ListTypesInput is a reference to a hash where the following keys are defined:
	type_name has a value which is a string
ListTypesOutput is a reference to a hash where the following keys are defined:
	types has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.TypeDescriptor
TypeDescriptor is a reference to a hash where the following keys are defined:
	type_name has a value which is a string
	type_ui_title has a value which is a string
	keys has a value which is a reference to a list where each element is a RESKESearchDemo.KeyDescription
KeyDescription is a reference to a hash where the following keys are defined:
	key_name has a value which is a string
	key_ui_title has a value which is a string
	key_value_type has a value which is a string


=end text

=item Description



=back

=cut

 sub list_types
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function list_types (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to list_types:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'list_types');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "RESKESearchDemo.list_types",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'list_types',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method list_types",
					    status_line => $self->{client}->status_line,
					    method_name => 'list_types',
				       );
    }
}
 
  
sub status
{
    my($self, @args) = @_;
    if ((my $n = @args) != 0) {
        Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
                                   "Invalid argument count for function status (received $n, expecting 0)");
    }
    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
        method => "RESKESearchDemo.status",
        params => \@args,
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
                           code => $result->content->{error}->{code},
                           method_name => 'status',
                           data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
                          );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method status",
                        status_line => $self->{client}->status_line,
                        method_name => 'status',
                       );
    }
}
   

sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
        method => "RESKESearchDemo.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'list_types',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method list_types",
            status_line => $self->{client}->status_line,
            method_name => 'list_types',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for RESKESearchDemo::RESKESearchDemoClient\n";
    }
    if ($sMajor == 0) {
        warn "RESKESearchDemo::RESKESearchDemoClient version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 boolean

=over 4



=item Description

A boolean. 0 = false, other = true.


=item Definition

=begin html

<pre>
an int
</pre>

=end html

=begin text

an int

=end text

=back



=head2 GUID

=over 4



=item Description

Global user identificator. It has structure like this:
  <data-source-code>:<full-reference>[:<sub-type>/<sub-id>]


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 AddWorkspaceToIndexInput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ws_name has a value which is a string
ws_id has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ws_name has a value which is a string
ws_id has a value which is an int


=end text

=back



=head2 MatchValue

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
value has a value which is a string
int_value has a value which is an int
double_value has a value which is a float
bool_value has a value which is a RESKESearchDemo.boolean
min_int has a value which is an int
max_int has a value which is an int
min_date has a value which is an int
max_date has a value which is an int
min_double has a value which is a float
max_double has a value which is a float

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
value has a value which is a string
int_value has a value which is an int
double_value has a value which is a float
bool_value has a value which is a RESKESearchDemo.boolean
min_int has a value which is an int
max_int has a value which is an int
min_date has a value which is an int
max_date has a value which is an int
min_double has a value which is a float
max_double has a value which is a float


=end text

=back



=head2 MatchFilter

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
full_text_in_all has a value which is a string
access_group_id has a value which is an int
object_name has a value which is a string
parent_guid has a value which is a RESKESearchDemo.GUID
timestamp has a value which is a RESKESearchDemo.MatchValue
lookupInKeys has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.MatchValue

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
full_text_in_all has a value which is a string
access_group_id has a value which is an int
object_name has a value which is a string
parent_guid has a value which is a RESKESearchDemo.GUID
timestamp has a value which is a RESKESearchDemo.MatchValue
lookupInKeys has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.MatchValue


=end text

=back



=head2 AccessFilter

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
with_private has a value which is a RESKESearchDemo.boolean
with_public has a value which is a RESKESearchDemo.boolean
with_all_history has a value which is a RESKESearchDemo.boolean

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
with_private has a value which is a RESKESearchDemo.boolean
with_public has a value which is a RESKESearchDemo.boolean
with_all_history has a value which is a RESKESearchDemo.boolean


=end text

=back



=head2 SearchTypesInput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
match_filter has a value which is a RESKESearchDemo.MatchFilter
access_filter has a value which is a RESKESearchDemo.AccessFilter

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
match_filter has a value which is a RESKESearchDemo.MatchFilter
access_filter has a value which is a RESKESearchDemo.AccessFilter


=end text

=back



=head2 SearchTypesOutput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
type_to_count has a value which is a reference to a hash where the key is a string and the value is an int
search_time has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
type_to_count has a value which is a reference to a hash where the key is a string and the value is an int
search_time has a value which is an int


=end text

=back



=head2 SortingRule

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
is_timestamp has a value which is a RESKESearchDemo.boolean
is_object_name has a value which is a RESKESearchDemo.boolean
key_name has a value which is a string
descending has a value which is a RESKESearchDemo.boolean

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
is_timestamp has a value which is a RESKESearchDemo.boolean
is_object_name has a value which is a RESKESearchDemo.boolean
key_name has a value which is a string
descending has a value which is a RESKESearchDemo.boolean


=end text

=back



=head2 Pagination

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
start has a value which is an int
count has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
start has a value which is an int
count has a value which is an int


=end text

=back



=head2 PostProcessing

=over 4



=item Description

ids_only - shortcut to mark all three skips as true.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ids_only has a value which is a RESKESearchDemo.boolean
skip_info has a value which is a RESKESearchDemo.boolean
skip_keys has a value which is a RESKESearchDemo.boolean
skip_data has a value which is a RESKESearchDemo.boolean
data_includes has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ids_only has a value which is a RESKESearchDemo.boolean
skip_info has a value which is a RESKESearchDemo.boolean
skip_keys has a value which is a RESKESearchDemo.boolean
skip_data has a value which is a RESKESearchDemo.boolean
data_includes has a value which is a reference to a list where each element is a string


=end text

=back



=head2 SearchObjectsInput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
object_type has a value which is a string
match_filter has a value which is a RESKESearchDemo.MatchFilter
sorting_rules has a value which is a reference to a list where each element is a RESKESearchDemo.SortingRule
access_filter has a value which is a RESKESearchDemo.AccessFilter
pagination has a value which is a RESKESearchDemo.Pagination
post_processing has a value which is a RESKESearchDemo.PostProcessing

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
object_type has a value which is a string
match_filter has a value which is a RESKESearchDemo.MatchFilter
sorting_rules has a value which is a reference to a list where each element is a RESKESearchDemo.SortingRule
access_filter has a value which is a RESKESearchDemo.AccessFilter
pagination has a value which is a RESKESearchDemo.Pagination
post_processing has a value which is a RESKESearchDemo.PostProcessing


=end text

=back



=head2 ObjectData

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
guid has a value which is a RESKESearchDemo.GUID
parent_guid has a value which is a RESKESearchDemo.GUID
object_name has a value which is a string
timestamp has a value which is an int
parent_data has a value which is an UnspecifiedObject, which can hold any non-null object
data has a value which is an UnspecifiedObject, which can hold any non-null object
key_props has a value which is a reference to a hash where the key is a string and the value is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
guid has a value which is a RESKESearchDemo.GUID
parent_guid has a value which is a RESKESearchDemo.GUID
object_name has a value which is a string
timestamp has a value which is an int
parent_data has a value which is an UnspecifiedObject, which can hold any non-null object
data has a value which is an UnspecifiedObject, which can hold any non-null object
key_props has a value which is a reference to a hash where the key is a string and the value is a string


=end text

=back



=head2 SearchObjectsOutput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
pagination has a value which is a RESKESearchDemo.Pagination
sorting_rules has a value which is a reference to a list where each element is a RESKESearchDemo.SortingRule
objects has a value which is a reference to a list where each element is a RESKESearchDemo.ObjectData
total has a value which is an int
search_time has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
pagination has a value which is a RESKESearchDemo.Pagination
sorting_rules has a value which is a reference to a list where each element is a RESKESearchDemo.SortingRule
objects has a value which is a reference to a list where each element is a RESKESearchDemo.ObjectData
total has a value which is an int
search_time has a value which is an int


=end text

=back



=head2 GetObjectsInput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
guids has a value which is a reference to a list where each element is a RESKESearchDemo.GUID
post_processing has a value which is a RESKESearchDemo.PostProcessing

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
guids has a value which is a reference to a list where each element is a RESKESearchDemo.GUID
post_processing has a value which is a RESKESearchDemo.PostProcessing


=end text

=back



=head2 GetObjectsOutput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
objects has a value which is a reference to a list where each element is a RESKESearchDemo.ObjectData
search_time has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
objects has a value which is a reference to a list where each element is a RESKESearchDemo.ObjectData
search_time has a value which is an int


=end text

=back



=head2 ListTypesInput

=over 4



=item Description

type_name - optional parameter; if not specified all types are described.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
type_name has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
type_name has a value which is a string


=end text

=back



=head2 KeyDescription

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
key_name has a value which is a string
key_ui_title has a value which is a string
key_value_type has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
key_name has a value which is a string
key_ui_title has a value which is a string
key_value_type has a value which is a string


=end text

=back



=head2 TypeDescriptor

=over 4



=item Description

TODO: add more details like parent type, relations, primary key, ...


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
type_name has a value which is a string
type_ui_title has a value which is a string
keys has a value which is a reference to a list where each element is a RESKESearchDemo.KeyDescription

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
type_name has a value which is a string
type_ui_title has a value which is a string
keys has a value which is a reference to a list where each element is a RESKESearchDemo.KeyDescription


=end text

=back



=head2 ListTypesOutput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
types has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.TypeDescriptor

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
types has a value which is a reference to a hash where the key is a string and the value is a RESKESearchDemo.TypeDescriptor


=end text

=back



=cut

package RESKESearchDemo::RESKESearchDemoClient::RpcClient;
use base 'JSON::RPC::Client';
use POSIX;
use strict;

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $headers, $obj) = @_;
    my $result;


    {
	if ($uri =~ /\?/) {
	    $result = $self->_get($uri);
	}
	else {
	    Carp::croak "not hashref." unless (ref $obj eq 'HASH');
	    $result = $self->_post($uri, $headers, $obj);
	}

    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $headers, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	@$headers,
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
