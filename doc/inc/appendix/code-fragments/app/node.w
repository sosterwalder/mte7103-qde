% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/application/node.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding node related aspects concerning the application layer.
"""

# System imports
import glob
import inspect
import os
import time
import uuid
from PyQt5 import Qt
from PyQt5 import QtCore

# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import type as types
from qde.editor.technical  import json
from qde.editor.domain     import parameter
from qde.editor.domain     import node as node_domain
from qde.editor.gui_domain import node as node_gui_domain


@<Node controller declarations@>
@}


@d Node controller signals
@{
do_add_node_model      = QtCore.pyqtSignal(node_domain.NodeModel)
do_add_node_view_model = QtCore.pyqtSignal(node_gui_domain.NodeViewModel)@}

@d Node controller slots
@{
@@QtCore.pyqtSlot(uuid.UUID)
def on_node_added(self, id):
    if id in self.node_definitions:
        node_definitions = self.node_definitions[id]

        domain_model = node_definitions[0]
        view_model   = node_definitions[1]

        # Create node domain model
        node_domain_model = node_domain.NodeModel(
            id_=domain_model.id_,
            name=domain_model.name
        )

        inputs = []
        for input in domain_model.inputs:
            self.logger.debug("Creating input %s", input.id_)
            input = node_domain.NodePart(input.id_, input.name, input.default_function)
            inputs.append(input)
        node_domain_model.inputs = inputs

        outputs = []
        for output in domain_model.outputs:
            self.logger.debug("Creating output %s of type %s", output.id_, output.type_)
            value = parameter.create_value(
                output.type_.name, ""
            )
            value_function = node_domain.create_value_function(value)
            output = node_domain.NodePart(output.id_, output.name, value_function, output.type_)
            outputs.append(output)
        node_domain_model.outputs = outputs

        definitions = []
        for definition in domain_model.definitions:
            self.logger.debug("Creating definition %s", definition.id_)
            value = parameter.create_value(
                types.NodeType.FLOAT.name, 0.0
            )
            value_function = node_domain.create_value_function(value)
            definition = node_domain.NodePart(
                definition.id_, definition.name, value_function, types.NodeType.FLOAT, definition.script
            )
            definitions.append(definition)
        node_domain_model.definitions = definition

        invocations = []
        for invocation in domain_model.invocations:
            self.logger.debug("Creating invocation %s", invocation.id_)
            value = parameter.create_value(
                types.NodeType.FLOAT.name, 0.0
            )
            value_function = node_domain.create_value_function(value)
            invocation = node_domain.NodePart(
                invocation.id_, invocation.name, value_function, types.NodeType.FLOAT, invocation.script
            )
            invocations.append(invocation)
        node_domain_model.invocations = invocations

        parts = []
        for part in domain_model.parts:
            self.logger.debug("Creating part %s", part.id_)
            value = parameter.create_value(
                output.type_.name, ""
            )
            value_function = node_domain.create_value_function(value)
            part = node_domain.NodePart(part.id_, part.name, value_function, part.type_)
            parts.append(output)
        node_domain_model.parts = parts

        # Create node view model
        node_view_model = node_gui_domain.NodeViewModel(
            id_=node_domain_model.id_,
            domain_object=node_domain_model
        )

        # Create connectors
        # TODO: Do this in view model?
        for inputs in domain_model.inputs:
            name = "%s (%s)" % (input.name, input.type_.name)
            node_input_view_model = node_gui_domain.NodeInputViewModel(
                name, node_view_model
            )
            node_view_model.inputs[node_input_view_model.id_] = node_input_view_model
        for output in domain_model.outputs:
            name = "%s (%s)" % (output.name, output.type_.name)
            node_output_view_model = node_gui_domain.NodeOutputViewModel(
                name, node_view_model
            )
            node_view_model.outputs[node_output_view_model.id_] = node_output_view_model

        # Inform other components about creation
        self.do_add_node_model.emit(node_domain_model)
        self.do_add_node_view_model.emit(node_view_model)
        self.logger.debug("Added new node %s" % (node_domain_model))
    else:
        self.logger.warn("%s: Node definition %s not found!" % (__name__, id))@}
