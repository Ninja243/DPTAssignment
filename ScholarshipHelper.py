import pyodbc
import socket
import os, traceback
from kivy import Config
from kivy.app import App
from kivy.lang import Builder
from kivy.metrics import dp
from kivy.uix.screenmanager import Screen, ScreenManager, WipeTransition, SwapTransition
from kivymd.theming import ThemeManager
from kivymd.toast import toast
from kivy.properties import ListProperty
from kivymd.uix.card import MDCard
from kivy.uix.button import Button
from kivy.uix.textinput import TextInput
from kivy.uix.boxlayout import BoxLayout
# Global variables start here
hostname = socket.gethostname()
conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+hostname+'\SQLEXPRESS;DATABASE=ScholarshipHelperDB;Trusted_Connection=yes;')
cursor = conn.cursor()
# Test if tables exist, if not, run the procedure to create them
# TODO
try:
	cursor.execute("")
except:
	cursor.execute("createTables")
# Attempt DB connection
#def connectDB():
#		conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+hostname+'\SQLEXPRESS;DATABASE=ScholarshipHelperDB;Trusted_Connection=yes;')
#		#
#		global cursor = conn.cursor()
#		conn.close()
#try:
#	connectDB()
#except Exception as e:
#	print("Error accessing database:")
#	print(str(e))
#	if ("Cannot open database \"ScholarshipHelperDB\"" in str(e)):
#		createDB()
#		connectDB()


# Prevent OpenGL error
os.environ['KIVY_GL_BACKEND'] = 'sdl2'
Config.set('graphics', 'multisamples', '0')

# Select files to use when building
Builder.load_string("""#:include kv/splashscreen.kv
#:include kv/viewscreen.kv
#:include kv/addscreen.kv
					""")

# Method for running the SQL file needed to create the schema
# TODO Auth issue
def createDB():
	# Read Table.sql for the DDL commands
	print("Attempting to create DB")
	tableSQL = open("SQL Files/Table.sql").read()
	conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+hostname+'\SQLEXPRESS;DATABASE=master;Trusted_Connection=yes;', autocommit=True)
	cursor = conn.cursor()
	cursor.execute(tableSQL)

def antiSQLi(key):
	key.replace(";", "")
	key.replace("--", "")
	key.replace("'", "")
	key.replace("\"", "")
	key.replace("=", "")
	return key

# Search for the first name using the search procedure
def searchFirstname(key):
	global cursor
	cursor.execute("EXEC spSearchPersonFirstName @SearchString="+antiSQLi(key))
	result = cursor.fetchall()
	return result

class ItemList(MDCard):
    def prepare_viewing_of_applicant(self):
        print(self.applicant_id)

class AddScreen(Screen):
	def __init__(self, **kwargs):
		super(AddScreen, self).__init__(**kwargs)
	def on_back_pressed(self, *args):
		UI().change_screen("splash_screen")
		UI().manage_screens("add_screen", "remove")

class ViewScreen(Screen):
	def __init__(self, **kwargs):
		super(ViewScreen, self).__init__(**kwargs)
		self.searchbar = self.ids['searchbar']
		self.searchButton = self.ids['searchButton']
		self.studentResult = self.ids['studentResult']
	
	def runSearch(self):
		self.studentResult.clear_widgets()
		result = (searchFirstname(self.searchbar.text))
		for row in result:
			
			self.studentResult.add_widget(Button(text=row, height="200dp"))
		
		
		self.h = 1
		self.studentResult.size = (200, 400)
		print(result)
		
	applicantData = ListProperty()

	def on_enter(self, *args):
		for i in range(4):
			self.add_applicant()
	
		
	def add_applicant(self):
		self.applicantData.append({
			
			}
		)
	def on_back_pressed(self, *args):
		UI().change_screen("splash_screen")
		UI().manage_screens("view_screen", "remove")

class SplashScreen(Screen):
    def __init__(self, **kwargs):
        super(SplashScreen, self).__init__(**kwargs)

class UI(App):
	global sm
	theme_cls = ThemeManager()
	theme_cls.primary_palette = "Blue"
	theme_cls.theme_style = "Light"
	sm = ScreenManager()
	
	def change_screen(self, screen_name):
		if sm.has_screen(screen_name):
			sm.current = screen_name
		else:
			print("Error finding screen ("+screen_name+")")
			
	def manage_screens(self, screen_name, action):
		scns = {
			"splash_screen": SplashScreen,
			"view_screen": ViewScreen,
			"add_screen": AddScreen
		}
		try:
			if action == "remove":
				if sm.has_screen(screen_name):
					sm.remove_widget(sm.get_screen(screen_name))
			elif action == "add":
				if sm.has_screen(screen_name):
					# already exists
					print("Screen already exists")
				else:
					sm.add_widget(scns[screen_name](name=screen_name))
		except:
			print(traceback.format_exc())
			print("Traceback ^.^")
	
	def change_screen(self, sc):
		sm.current = sc
		
	def build(self):
		global sm
		self.bind(on_start=self.post_build_init)
		sm = ScreenManager(transition=SwapTransition())
		sm.add_widget(SplashScreen(name="splash_screen"))
		return sm
	
	def post_build_init(self, ev):
		win = self._app_window
		win.bind(on_keyboard=self._key_handler)
	
	def _key_handler(self, *args):
		key = args[1]
        # 1000 is "back" on Android
        # 27 is "escape" on computers
		if key in (1000, 27):
			try:
				sm.current_screen.dispatch("on_back_pressed")
			except Exception as e:
				print(e)
			return True
		elif key == 1001:
			try:
				sm.current_screen.dispatch("on_menu_pressed")
			except Exception as e:
				print(e)
		return True
	


if __name__ == "__main__":
    UI().run()