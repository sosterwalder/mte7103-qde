from kivy.animation import Animation
from kivy.app import App
from kivy.core.window import Window
from kivy.graphics import Color
from kivy.graphics import Ellipse
from kivy.graphics import Line
from kivy.uix.widget import Widget


class ProjCenter(Widget):
    def __init__(self, **kwargs):
        super(ProjCenter, self).__init__(**kwargs)

        self.pos = [10, 10]
        self.size = [10, 10]

    def redraw(self):
        with self.canvas:
            Color(0.83, 0.88, 1)
            Ellipse(pos=self.pos, size=self.size)


class Ray(Widget):
    def __init__(self, **kwargs):
        super(Ray, self).__init__(**kwargs)
        self._was_triggered = False
        self.source = []
        self.target = []

    def trigger(self):
        if not self._was_triggered:
            self.canvas.clear()
            line = Line(points=[
                self.source[0] + 5,
                self.source[1] + 5,
                self.source[0] + 5,
                self.source[1] + 5,
            ],
                        width=1,
                        dash_length=5,
                        dash_offset=10
            )
            anim = Animation(points=[
                self.source[0] + 5,
                self.source[1] + 5,
                self.target[0],
                self.target[1]
            ])
            self.canvas.add(Color(0.83, 0.88, 1))
            self.canvas.add(line)
            anim.start(line)
            self._was_triggered = True
            print(self, " was triggered")


class RayTracingWidget(Widget):
    def __init__(self, **kwargs):
        super(RayTracingWidget, self).__init__(**kwargs)

        self.center = Window.center
        self.width  = Window.width
        self.height = Window.height
        print(self.center, self.center_x)

        self.proj_center = ProjCenter(**kwargs)
        self.proj_center.pos = [
            10, self.center_y / 2
        ]
        self.add_widget(self.proj_center)
        self.proj_center.redraw()

        self.rays = []
        for i in range(4):
            ray = Ray(**kwargs)
            ray.source = [
                10, self.center_y / 2
            ]
            ray.target = [self.center_x, self.center_y]
            self.rays.append(ray)

    def trigger(self):
        for ray in self.rays:
            ray.trigger()


class RayTracingApp(App):
    def __init__(self, **kwargs):
        super(RayTracingApp, self).__init__(**kwargs)
        self._keyboard = Window.request_keyboard(self._keyboard_closed, self)
        self._keyboard.bind(on_key_down = self._on_keyboard_down)

    def _keyboard_closed(self):
        self._keyboard.unbind(on_key_down = self._on_keyboard_down)
        self._keyboard = None

    def _on_keyboard_down(self, keyboard, keycode, text, modifiers):
        if keycode[1] == 'spacebar':
            self.root.trigger()

    def build(self):
        Window.clearcolor = (1, 1, 1, 1)
        return RayTracingWidget()


if __name__ == '__main__':
    RayTracingApp().run()
