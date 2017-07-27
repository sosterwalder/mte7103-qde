% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/technical/json.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding JSON related aspects.
"""

# System imports
import json
import uuid

# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import type as types
from qde.editor.domain import node
from qde.editor.domain import parameter


@<JSON module declarations@>
@}

@d JSON module declarations
@{
@@common.with_logger
class Json(object):
    """Class handling JSON relevant tasks.
    """

    @<JSON methods@>
@}

@d JSON methods
@{
@@classmethod
def build_node_definition_connection(cls, json_input):
    """Builds and returns a connection for a node definition from the given
    JSON input data.

    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: the connection of a node definition.
    :rtype:  qde.editor.domain.node.NodeDefinitionConnection
    """

    source_node_id = uuid.UUID(json_input['source_node'])
    source_part_id = uuid.UUID(json_input['source_part'])
    target_node_id = uuid.UUID(json_input['target_node'])
    target_part_id = uuid.UUID(json_input['target_part'])

    node_definition_connection = node.NodeDefinitionConnection(
        source_node_id,
        source_part_id,
        target_node_id,
        target_part_id
    )

    cls.logger.debug("Built node definition connection")
    return node_definition_connection
@}

@d JSON methods
@{
@@classmethod
def build_node_definition_definition(cls, json_input):
    """Builds and returns a definition for a node definition from the given
    JSON input data.

    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: the definition of a node definition.
    :rtype:  qde.editor.domain.node.NodeDefinitionDefinition
    """

    definition_id = uuid.UUID(json_input['id_'])
    script        = str(json_input['script'])

    node_definition_definition = node.NodeDefinitionDefinition(
        definition_id,
        script
    )

    cls.logger.debug("Built node definition definition")
    return node_definition_definition
@}

@d JSON methods
@{
@@classmethod
def build_node_definition_invocation(cls, json_input):
    """Builds and returns a invocation for a node definition from the given
    JSON input data.

    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: the invocation of a node definition.
    :rtype:  qde.editor.domain.node.NodeDefinitionInvocation
    """

    invocation_id = uuid.UUID(json_input['id_'])
    script        = str(json_input['script'])

    node_definition_invocation = node.NodeDefinitionInvocation(
        invocation_id,
        script
    )

    cls.logger.debug("Built node definition invocation")
    return node_definition_invocation
@}