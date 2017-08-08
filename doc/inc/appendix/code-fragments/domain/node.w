% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/domain/node.py
@{# -*- coding: utf-8 -*-

"""Module for node-specific aspects."""

# System imports

# Project imports
from qde.editor.foundation import type as types
from qde.editor.foundation import flag

@<Node domain model declarations@>
@<Node part domain model declarations@>
@<Node definition domain model declarations@>
@<Node definition part domain model declarations@>
@<Node definition input domain model declarations@>
@<Node definition output domain model declarations@>
@<Node definition connection domain model declarations@>
@<Node definition definition domain model declarations@>
@<Node definition invocation domain model declarations@>
@<Node domain module methods@>
@}


@d Node definition connection domain model declarations
@{
class NodeDefinitionConnection(object):
    """Represents a connection of a definition of a node."""

    # Constants
    NAME = "Connection"

    # Signals


    def __init__(self,
                 source_node_id, source_part_id,
                 target_node_id, target_part_id):
        """Constructor.

        :param source_node_id: the identifier of the source node.
        :type  source_node_id: uuid.uuid4
        :param source_part_id: the identifier of the part of the source node.
        :type  source_part_id: uuid.uuid4
        :param target_node_id: the identifier of the target node.
        :type  target_node_id: uuid.uuid4
        :param target_part_id: the identifier of the part of the target node.
        :type  target_part_id: uuid.uuid4
        """

        self.source_node_id = source_node_id
        self.source_part_id = source_part_id
        self.target_node_id = target_node_id
        self.target_part_id = target_part_id

    @@property
    def name(self):
        return self.NAME
@}

@d Node definition definition domain model declarations
@{
class NodeDefinitionDefinition(object):
    """Represents a definition part of a definition of a node."""

    # Constants
    NAME = "Definition"


    def __init__(self, id_, script):
        """Constructor.

        :param id_: the globally unique identifier of the definition.
        :type  id_: uuid.uuid4
        :param script: the script part of the definition.
        :param script: str
        """

        self.id_ = id_
        self.script = script

    @@property
    def name(self):
        return self.NAME
@}

@d Node definition invocation domain model declarations
@{
class NodeDefinitionInvocation(object):
    """Represents an invocation of a definition of a node."""

    # Constants
    NAME = "Invocation"


    def __init__(self, id_, script):
        """Constructor.

        :param id_: the globally unique identifier of the definition.
        :type  id_: uid.uuid4
        :param script: the script part of the invocation.
        :param script: str
        """

        self.id_ = id_
        self.script = script

    @@property
    def name(self):
        return self.NAME
@}

@d Node definition output domain model methods
@{
@@property
def type_(self):
    """returns the type of the node definition output.

    :return: the type of the output given by the node definition part
    :rtype:  qde.editor.foundation.types.nodetype
    """

    return self.node_definition_part.type_
@}
