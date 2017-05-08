# -*- coding: utf-8 -*-
#BEGIN_HEADER
#END_HEADER


class RESKESearchDemo:
    '''
    Module Name:
    RESKESearchDemo

    Module Description:
    A KBase module: RESKESearchDemo
    '''

    ######## WARNING FOR GEVENT USERS ####### noqa
    # Since asynchronous IO can lead to methods - even the same method -
    # interrupting each other, you must be *very* careful when using global
    # state. A method could easily clobber the state set by another while
    # the latter method is running.
    ######################################### noqa
    VERSION = "0.0.1"
    GIT_URL = "https://github.com/kbaseapps/RESKESearchDemo"
    GIT_COMMIT_HASH = "8107c2de43886e7d6910585064044b84d349e94b"

    #BEGIN_CLASS_HEADER
    #END_CLASS_HEADER

    # config contains contents of config file in a hash or None if it couldn't
    # be found
    def __init__(self, config):
        #BEGIN_CONSTRUCTOR
        #END_CONSTRUCTOR
        pass


    def add_workspace_to_index(self, ctx, params):
        """
        This operation means that given workspace will be shared with
        system indexing user with write access. User calling this
        function should be owner of this workspace.
        :param params: instance of type "AddWorkspaceToIndexInput" ->
           structure: parameter "ws_name" of String, parameter "ws_id" of Long
        """
        # ctx is the context object
        #BEGIN add_workspace_to_index
        #END add_workspace_to_index
        pass

    def search_types(self, ctx, params):
        """
        :param params: instance of type "SearchTypesInput" -> structure:
           parameter "match_filter" of type "MatchFilter" -> structure:
           parameter "full_text_in_all" of String, parameter
           "access_group_id" of Long, parameter "object_name" of String,
           parameter "parent_guid" of type "GUID" (Global user identificator.
           It has structure like this:
           <data-source-code>:<full-reference>[:<sub-type>/<sub-id>]),
           parameter "timestamp" of type "MatchValue" -> structure: parameter
           "value" of String, parameter "int_value" of Long, parameter
           "double_value" of Double, parameter "bool_value" of type "boolean"
           (A boolean. 0 = false, other = true.), parameter "min_int" of
           Long, parameter "max_int" of Long, parameter "min_date" of Long,
           parameter "max_date" of Long, parameter "min_double" of Double,
           parameter "max_double" of Double, parameter "lookupInKeys" of
           mapping from String to type "MatchValue" -> structure: parameter
           "value" of String, parameter "int_value" of Long, parameter
           "double_value" of Double, parameter "bool_value" of type "boolean"
           (A boolean. 0 = false, other = true.), parameter "min_int" of
           Long, parameter "max_int" of Long, parameter "min_date" of Long,
           parameter "max_date" of Long, parameter "min_double" of Double,
           parameter "max_double" of Double, parameter "access_filter" of
           type "AccessFilter" -> structure: parameter "with_private" of type
           "boolean" (A boolean. 0 = false, other = true.), parameter
           "with_public" of type "boolean" (A boolean. 0 = false, other =
           true.), parameter "with_all_history" of type "boolean" (A boolean.
           0 = false, other = true.)
        :returns: instance of type "SearchTypesOutput" -> structure:
           parameter "type_to_count" of mapping from String to Long,
           parameter "search_time" of Long
        """
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN search_types
        client = RESKESearchDemoImpl("http://dev01.kbase.lbl.gov:29999/", token=ctx['token'])
        returnVal = client.search_types(params)
        #END search_types

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method search_types return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def search_objects(self, ctx, params):
        """
        :param params: instance of type "SearchObjectsInput" -> structure:
           parameter "object_type" of String, parameter "match_filter" of
           type "MatchFilter" -> structure: parameter "full_text_in_all" of
           String, parameter "access_group_id" of Long, parameter
           "object_name" of String, parameter "parent_guid" of type "GUID"
           (Global user identificator. It has structure like this:
           <data-source-code>:<full-reference>[:<sub-type>/<sub-id>]),
           parameter "timestamp" of type "MatchValue" -> structure: parameter
           "value" of String, parameter "int_value" of Long, parameter
           "double_value" of Double, parameter "bool_value" of type "boolean"
           (A boolean. 0 = false, other = true.), parameter "min_int" of
           Long, parameter "max_int" of Long, parameter "min_date" of Long,
           parameter "max_date" of Long, parameter "min_double" of Double,
           parameter "max_double" of Double, parameter "lookupInKeys" of
           mapping from String to type "MatchValue" -> structure: parameter
           "value" of String, parameter "int_value" of Long, parameter
           "double_value" of Double, parameter "bool_value" of type "boolean"
           (A boolean. 0 = false, other = true.), parameter "min_int" of
           Long, parameter "max_int" of Long, parameter "min_date" of Long,
           parameter "max_date" of Long, parameter "min_double" of Double,
           parameter "max_double" of Double, parameter "sorting_rules" of
           list of type "SortingRule" -> structure: parameter "is_timestamp"
           of type "boolean" (A boolean. 0 = false, other = true.), parameter
           "is_object_name" of type "boolean" (A boolean. 0 = false, other =
           true.), parameter "key_name" of String, parameter "descending" of
           type "boolean" (A boolean. 0 = false, other = true.), parameter
           "access_filter" of type "AccessFilter" -> structure: parameter
           "with_private" of type "boolean" (A boolean. 0 = false, other =
           true.), parameter "with_public" of type "boolean" (A boolean. 0 =
           false, other = true.), parameter "with_all_history" of type
           "boolean" (A boolean. 0 = false, other = true.), parameter
           "pagination" of type "Pagination" -> structure: parameter "start"
           of Long, parameter "count" of Long, parameter "post_processing" of
           type "PostProcessing" (ids_only - shortcut to mark all three skips
           as true.) -> structure: parameter "ids_only" of type "boolean" (A
           boolean. 0 = false, other = true.), parameter "skip_info" of type
           "boolean" (A boolean. 0 = false, other = true.), parameter
           "skip_keys" of type "boolean" (A boolean. 0 = false, other =
           true.), parameter "skip_data" of type "boolean" (A boolean. 0 =
           false, other = true.), parameter "data_includes" of list of String
        :returns: instance of type "SearchObjectsOutput" -> structure:
           parameter "pagination" of type "Pagination" -> structure:
           parameter "start" of Long, parameter "count" of Long, parameter
           "sorting_rules" of list of type "SortingRule" -> structure:
           parameter "is_timestamp" of type "boolean" (A boolean. 0 = false,
           other = true.), parameter "is_object_name" of type "boolean" (A
           boolean. 0 = false, other = true.), parameter "key_name" of
           String, parameter "descending" of type "boolean" (A boolean. 0 =
           false, other = true.), parameter "objects" of list of type
           "ObjectData" -> structure: parameter "guid" of type "GUID" (Global
           user identificator. It has structure like this:
           <data-source-code>:<full-reference>[:<sub-type>/<sub-id>]),
           parameter "parent_guid" of type "GUID" (Global user identificator.
           It has structure like this:
           <data-source-code>:<full-reference>[:<sub-type>/<sub-id>]),
           parameter "object_name" of String, parameter "timestamp" of Long,
           parameter "parent_data" of unspecified object, parameter "data" of
           unspecified object, parameter "key_props" of mapping from String
           to String, parameter "total" of Long, parameter "search_time" of
           Long
        """
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN search_objects
        client = RESKESearchDemoImpl("http://dev01.kbase.lbl.gov:29999/", token=ctx['token'])
        returnVal = client.search_objects(params)
        #END search_objects

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method search_objects return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def get_objects(self, ctx, params):
        """
        :param params: instance of type "GetObjectsInput" -> structure:
           parameter "guids" of list of type "GUID" (Global user
           identificator. It has structure like this:
           <data-source-code>:<full-reference>[:<sub-type>/<sub-id>]),
           parameter "post_processing" of type "PostProcessing" (ids_only -
           shortcut to mark all three skips as true.) -> structure: parameter
           "ids_only" of type "boolean" (A boolean. 0 = false, other =
           true.), parameter "skip_info" of type "boolean" (A boolean. 0 =
           false, other = true.), parameter "skip_keys" of type "boolean" (A
           boolean. 0 = false, other = true.), parameter "skip_data" of type
           "boolean" (A boolean. 0 = false, other = true.), parameter
           "data_includes" of list of String
        :returns: instance of type "GetObjectsOutput" -> structure: parameter
           "objects" of list of type "ObjectData" -> structure: parameter
           "guid" of type "GUID" (Global user identificator. It has structure
           like this:
           <data-source-code>:<full-reference>[:<sub-type>/<sub-id>]),
           parameter "parent_guid" of type "GUID" (Global user identificator.
           It has structure like this:
           <data-source-code>:<full-reference>[:<sub-type>/<sub-id>]),
           parameter "object_name" of String, parameter "timestamp" of Long,
           parameter "parent_data" of unspecified object, parameter "data" of
           unspecified object, parameter "key_props" of mapping from String
           to String, parameter "search_time" of Long
        """
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN get_objects
        #END get_objects

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method get_objects return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def list_types(self, ctx, params):
        """
        :param params: instance of type "ListTypesInput" (type_name -
           optional parameter; if not specified all types are described.) ->
           structure: parameter "type_name" of String
        :returns: instance of type "ListTypesOutput" -> structure: parameter
           "types" of mapping from String to type "TypeDescriptor" (TODO: add
           more details like parent type, relations, primary key, ...) ->
           structure: parameter "type_name" of String, parameter
           "type_ui_title" of String, parameter "keys" of list of type
           "KeyDescription" -> structure: parameter "key_name" of String,
           parameter "key_ui_title" of String, parameter "key_value_type" of
           String
        """
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN list_types
        #END list_types

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method list_types return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]
    def status(self, ctx):
        #BEGIN_STATUS
        returnVal = {'state': "OK",
                     'message': "",
                     'version': self.VERSION,
                     'git_url': self.GIT_URL,
                     'git_commit_hash': self.GIT_COMMIT_HASH}
        #END_STATUS
        return [returnVal]
