import os
import traceback

from kivy import Config
from kivy.app import App
from kivy.lang import Builder
from kivy.uix.screenmanager import Screen, ScreenManager, WipeTransition

from kivymd.theming import ThemeManager
from kivymd.toast import toast

# kivy throws an opengl error at times (some systems especially VM's)
# this fixes it
os.environ['KIVY_GL_BACKEND'] = 'sdl2'
Config.set('graphics', 'multisamples', '0')

Builder.load_string("""
#:include kv/homescreen.kv
# without including the files, you'll end up with a white/blank screen 
# so let's include the file with our second screen
#:include kv/someotherscreen.kv

    """)


class HomeScreen(Screen):
    def __init__(self, **kwargs):
        super(HomeScreen, self).__init__(**kwargs)

    def callback_for_button(self, a_param):
        toast(a_param)


class SecondScreen(Screen):
    def __init__(self, **kwargs):
        super(SecondScreen, self).__init__(**kwargs)

    def on_back_pressed(self):
        # home_screen is always there; unless we removed at some point then you'll need this
        # MainController().manage_screens("home_screen", "add")
        # but it shouldn't really matter as it won't add if it is already there

        MainController().change_screen("home_screen")


class MainController(App):
    global sm
    theme_cls = ThemeManager()
    theme_cls.primary_palette = 'Indigo'
    theme_cls.theme_style = "Light"
    sm = ScreenManager()

    def change_screen(self, screen_name):
        if sm.has_screen(screen_name):
            sm.current = screen_name
        else:
            print("Screen [" + screen_name + "] does not exist.")

    def manage_screens(self, screen_name, action):
        # register your screens here
        # "name_to_call_it": ClassName
        # adding second screen now
        scns = {
            "home_screen": HomeScreen,
            "second_screen": SecondScreen
        }
        try:

            if action == "remove":
                if sm.has_screen(screen_name):
                    sm.remove_widget(sm.get_screen(screen_name))
                    print("Screen [" + screen_name + "] removed")
            elif action == "add":
                if sm.has_screen(screen_name):
                    print("Screen [" + screen_name + "] already exists")
                else:
                    sm.add_widget(scns[screen_name](name=screen_name))
                    print(screen_name + " added")
                    # print("Screen ["+screen_name+"] added")
        except:
            print(traceback.format_exc())

    def change_screen(self, sc):
        sm.current = sc

    def build(self):
        global sm
        sm = ScreenManager(transition=WipeTransition())
        # the default screen when the app loads
        sm.add_widget(HomeScreen(name="home_screen"))
        return sm


if __name__ == "__main__":
    MainController().run()
