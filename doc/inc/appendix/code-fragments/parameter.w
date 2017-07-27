% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/domain/parameter.py
@{# -*- coding: utf-8 -*-

"""Module for parameter-specific aspects."""

# System imports

# Project imports
from qde.editor.foundation import type as types
from qde.editor.domain import node

@<Parameter declarations@>
@<Paramater domain model value generic interface@>
@<Paramater domain model value interface@>
@<Paramater domain model float value@>
@<Paramater domain model text value@>
@<Paramater domain model scene value@>
@<Paramater domain model implicit value@>
@<Parameter domain module methods@>
@}

@d Parameter declarations
@{
    FloatValue = create_node_definition_part.__func__(
        id_="468aea9e-0a03-4e63-b6b4-8a7a76775a1a",
        type_=types.NodeType.FLOAT
    )
    Text = create_node_definition_part.__func__(
        id_="e43bdd1b-a895-4bd8-8d5a-b401a63f7a6f",
        type_=types.NodeType.TEXT
    )
    Scene = create_node_definition_part.__func__(
        id_="bfb47e7text7-1b05-4864-8397-de30bf005ff8",
        type_=types.NodeType.SCENE
    )
    Image = create_node_definition_part.__func__(
        id_="21fd1960-1307-4b53-b7bf-d08f02757335",
        type_=types.NodeType.IMAGE
    )
    DynamicValue = create_node_definition_part.__func__(
        id_="68720ae3-8068-43ce-94d8-8705dc3b8bfe",
        type_=types.NodeType.DYNAMIC
    )
    Mesh = create_node_definition_part.__func__(
        id_="9791d341-b92c-43dd-954a-9d83b9020e43",
        type_=types.NodeType.MESH
    )
    Implicit = create_node_definition_part.__func__(
        id_="c019271c-35b6-425c-9ff2-a1d893111adb",
        type_=types.NodeType.IMPLICIT
    )

    atomic_types = [
        FloatValue,
        Text,
        Scene,
        Image,
        DynamicValue,
        Mesh,
        Implicit,
    ]

@}

@d Paramater domain model text value
@{
class TextValue(Value):
    """A class holding values for text/string nodes."""

    def __init__(self, string_value):
        """Constructor.

        :param string_value: the string value that shall be held
        :type  string_value: str
        """

        super(TextValue, self).__init__(string_value)
        self.function_type = types.NodeType.TEXT

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return TextValue(self.value)@}

@d Paramater domain model image value
@{
class ImageValue(ValueInterface):
    """A class holding values for image nodes."""

    def __init__(self):
        """Constructor."""

        super(ImageValue, self).__init__()
        self.function_type = types.NodeType.IMAGE

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return ImageValue()@}

@d Paramater domain model generic value
@{
class GenericValue(ValueInterface):
    """A class holding values for generic nodes."""

    def __init__(self):
        """Constructor."""

        super(GenericValue, self).__init__()
        self.function_type = types.NodeType.GENERIC

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return GenericValue()@}

@d Paramater domain model dynamic value
@{
class DynamicValue(ValueInterface):
    """A class holding values for dynamic nodes."""

    def __init__(self):
        """Constructor."""

        super(DynamicValue, self).__init__()
        self.function_type = types.NodeType.DYNAMIC

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return DynamicValue()@}

@d Paramater domain model mesh value
@{
class MeshValue(ValueInterface):
    """A class holding values for mesh nodes."""

    def __init__(self):
        """Constructor."""

        super(MeshValue, self).__init__()
        self.function_type = types.NodeType.MESH

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return MeshValue()@}

@d Paramater domain model implicit value
@{
class ImplicitValue(ValueInterface):
    """A class holding values for implicit surface nodes."""

    def __init__(self):
        """Constructor."""

        super(ImplicitValue, self).__init__()
        self.function_type = types.NodeType.IMPLICIT

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return ImplicitValue()@}

@d Paramater domain model implicit value
@{
class ImplicitValue(ValueInterface):
    """A class holding values for implicit types."""

    def __init__(self):
        """Constructor."""

        super(ImplicitValue, self).__init__()
        self.function_type = types.NodeType.IMPLICIT

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return ImplicitValue()@}
