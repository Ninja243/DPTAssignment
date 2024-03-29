import pyodbc
import socket
import functools
import os
import traceback
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
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput
from kivy.uix.boxlayout import BoxLayout
from decimal import Decimal
from kivymd.uix.picker import MDDatePicker
import datetime

# Global variables start here
hostname = socket.gethostname()
conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=' +
                      hostname + '\\SQLEXPRESS;DATABASE=ScholarshipHelperDB;Trusted_Connection=yes;')
cursor = conn.cursor()
# #Test if tables exist, if not, run the procedure to create them
# # TODO
try:
	cursor.execute("Select * From Person")
except:
	cursor.execute("createTables")
# Attempt DB connection
# def connectDB():
#		conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+hostname+'\SQLEXPRESS;DATABASE=ScholarshipHelperDB;Trusted_Connection=yes;')
#		#
#		global cursor = conn.cursor()
#		conn.close()
# try:
#	connectDB()
# except Exception as e:
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
#:include kv/studentinfo.kv
#:include kv/login.kv
#:import utils kivy.utils
""")


# Method for running the SQL file needed to create the schema
# TODO Auth issue
def createDB():
    # Read Table.sql for the DDL commands
    toast("Attempting to create DB")
    tableSQL = open("SQL Files/Table.sql").read()
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};SERVER=' + hostname +
            '\SQLEXPRESS;DATABASE=master;Trusted_Connection=yes;',
        autocommit=True)
    cursor = conn.cursor()
    cursor.execute(tableSQL)


def antiSQLi(key):
	key = str(key)
	if isinstance(key, str):
		key = key.replace(";", " ")
		key = key.replace("--", " ")
		key = key.replace("'", " ")
		key = key.replace("\"", " ")
		key = key.replace("=", " ")
		key = key.replace(".", " ")
		key = key.replace("/", " ")
	if isinstance(key, int):
		# key = Decimal(key)
		key = Decimal(key.strip(' "'))
		# print(pyodbc.SQLDescribeParam(key))
	return key


# Search for the first name using the search procedure
def searchFirstname(key):
    global cursor
    asqlikey = antiSQLi(key)
    cursor.execute("EXEC spSearchPersonFirstName @SearchString=" + asqlikey)
    result = cursor.fetchall()
    return result

# Insert info for a new Person


def insertPerson(idNumber, FirstName, Surname, dob):
	try:
		idNumber = antiSQLi(idNumber)
		FirstName = antiSQLi(FirstName)
		Surname = antiSQLi(Surname)
		dob = antiSQLi(dob)
		# print("@insert: "+str(idNumber)+" "+FirstName+" "+Surname+" "+str(dob))
		p = (idNumber, FirstName, Surname, dob)
		# Don't care about truncation of the date
		cursor.execute(
		    "SET ANSI_WARNINGS OFF; EXEC spAddPerson @PersonIDNumber=?, @PersonFirstname=?, @PersonLastname=?, @PersonDoB=?", p)
		cursor.commit()
		cursor.execute("SET ANSI_WARNINGS ON;")
        toast(Firstname+" added!")
	except Exception as e:
		print(str(e))
        toast("Error adding user, check the CMD window")


class ItemList(MDCard):
    def prepare_viewing_of_applicant(self):
        print(self.applicant_id)


class LoginScreen(Screen):
	def __init__(self, **kwargs):
		super(LoginScreen, self).__init__(**kwargs)
		self.PasswordField = self.ids["PasswordField"]
		self.UsernameField = self.ids["UsernameField"]
		self.loginNotification = self.ids["loginNotification"]

	def Login(self, *args):
		# Get username and password
		Username = self.UsernameField.text
		Password = self.PasswordField.text
		try:
			if Username == "defaultAdmin":
				if Password == "defaultPassword":
					UI().manage_screens("splash_screen", "add")
					UI().change_screen("splash_screen")
					UI().manage_screens("login_screen", "remove")
				else:
                    toast("Your details do not match a user in our system")
					# self.loginNotification.text = "Your details do not match a user in our system"
			else:
                toast("Your details do not match a user in our system")
				# self.loginNotification.text = "Your details do not match a user in our system"
			if (conn.execute("EXEC spLogin @Username=?, @Password=?", Username, Password) == [] ):
                toast("Your details do not match a user in our system")
				# self.loginNotification.text = "Your details do not match a user in our system"
			else:
				UI().manage_screens("splash_screen", "add")
				UI().change_screen("splash_screen")
				UI().manage_screens("login_screen", "remove")
		except Exception as e:
			self.loginNotification.text = str(e)
            toast(str(e))
	def on_back_pressed(self, *args):
		conn.close()
		exit()

class AddScreen(Screen):
    def __init__(self, **kwargs):
        super(AddScreen, self).__init__(**kwargs)
        self.idNumDateConfLabel = self.ids["idNumDateConfLabel"]
        self.snameTextField = self.ids["snameTextField"]
        self.fnameTextField = self.ids["fnameTextField"]
        self.idNumTextField = self.ids["idNumTextField"]
        self.dateOfBirth = datetime.datetime.now()

    def showDatePicker(self, *args):
        try:
            MDDatePicker(self.handleDate).open()
        except AttributeError:
            MDDatePicker(self.handleDate).open()
    def handleDate(self, date):
        self.dateOfBirth = date
        self.updateDateLabel()
        # print(self.dateOfBirth)

    def addPerson(self, *args):
        insertPerson(self.idNumTextField.text, self.fnameTextField.text, self.snameTextField.text, self.dateOfBirth)

    def on_enter(self, *args):
        self.updateDateLabel()

    def updateDateLabel(self, *args):
        self.idNumDateConfLabel.text = datetime.datetime.strftime(self.dateOfBirth,"%A, %d %B %Y")

    def on_back_pressed(self, *args):
        UI().change_screen("splash_screen")
        UI().manage_screens("add_screen", "remove")


class StudentInfo(Screen):
    def __init__(self, **kwargs):
        super(StudentInfo, self).__init__(**kwargs)
        self.firstnameLabel = self.ids["firstnameLabel"]
        self.surnameLabel = self.ids["surnameLabel"]
        self.idnumberLabel = self.ids["idnumberLabel"]
        self.dateofbirthLabel = self.ids["dateofbirthLabel"]

    def on_enter(self, *args):
        cursor.execute("EXEC spFindPersonFromID @ID=?", antiSQLi(UI.currentID))
        result = cursor.fetchone()
        self.firstnameLabel.text = str(result[1])
        self.surnameLabel.text = str(result[2])
        self.idnumberLabel.text = str(result[0])
        self.dateofbirthLabel.text = str(result[3])


    def on_back_pressed(self, *args):
        UI().manage_screens("view_screen", "add")
        UI().change_screen("view_screen")
        UI().manage_screens("student_info", "remove")


class ViewScreen(Screen):
    def __init__(self, **kwargs):
        super(ViewScreen, self).__init__(**kwargs)
        self.searchbar = self.ids['searchbar']
        self.searchButton = self.ids['searchButton']
        self.studentResult = self.ids['studentResult']
        self.resultText = self.ids['resultText']

    def viewStudent(self, name, id_num, *args):
        # print(name, id_num)
        UI().manage_screens("student_info", "add")
        UI().change_screen("student_info")
        UI().manage_screens("view_screen", "remove")

    def runSearch(self):
        self.studentResult.clear_widgets()
        result = (searchFirstname(self.searchbar.text))
        i = 0
        for row in result:
            i = i + 1
            firstname = str(row[0])
            secondname = str(row[1])
            IDNumber = str(row[2])
            person = firstname + " " + secondname + " (" + IDNumber + ")"
# self.studentResult.add_widget(Button(text=person, height="200dp", on_press=self.viewStudent))
            self.add_applicant(person, IDNumber)

        # Testing
        # j = 0
        # while j < 10:
        # 	self.studentResult.add_widget(Button(text="Test Button", height="60dp", on_press=self.viewStudent))
        # 	i = i + 1
        # 	j = j + 1
        #
        # self.studentResult.add_widget(Button(text="Test Button", height="60dp", on_press=self.viewStudent))
        # i = i + 1
        # self.studentResult.add_widget(
        #     Label(text="[color=000000]" + str(i) + " results found[/color]", markup=True, height="60dp"))
        if (i == 1):
            self.resultText.text = str(i) + " result found"
        else:
            self.resultText.text = str(i) + " results found"
        # for row in result:
        #	i = i+1
        #	firstname = str(row[0])
        #	secondname = str(row[1])
        #	dob = str(row[2])
        #	person = firstname+" "+secondname+" ("+dob+")"
        #	self.studentResult.add_widget(Button(text=person, height="200dp", on_press=self.viewStudent))
        #
        # self.studentResult.add_widget(Label(text="[color=000000]"+str(i)+" results found[/color]",markup=True, height="60dp"))

        self.h = 1
        self.studentResult.size = (200, 400)
        # print(result)

    applicantData = ListProperty()

    # def on_enter(self, *args):
    #    for i in range(15):
    #        self.add_applicant("first/last name", i)
    #    self.resultText.text = "15 results found"

    def add_applicant(self, name, id_num):
        self.studentResult.add_widget(Button(text=name, on_release=functools.partial(self.viewStudent, name, id_num)))
        UI.currentID = int(id_num)

    # self.applicantData.append({
    #
    # }
    # )

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
    currentID = 0
    # Variables for person to be added to DB
    # firstname = ""
    # lastname = ""
    # idnum = 0
    # dateOfBirth = datetime.datetime.now()

    # def change_screen(self, screen_name):
    #	if sm.has_screen(screen_name):
    #		sm.current = screen_name
    #	else:
    #		print("Error finding screen ("+screen_name+")")

    def manage_screens(self, screen_name, action):
        scns = {
            "student_info": StudentInfo,
            "splash_screen": SplashScreen,
            "view_screen": ViewScreen,
            "add_screen": AddScreen,
            "login_screen": LoginScreen

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
            toast("Error occurred, check traceback")

    def change_screen(self, sc):
        try:
            sm.current = sc
        except:
            print(traceback.format_exc())

    def build(self):
        global sm
        self.bind(on_start=self.post_build_init)
        sm = ScreenManager(transition=SwapTransition())
        sm.add_widget(LoginScreen(name="login_screen"))
        return sm

    def post_build_init(self, ev):
        win = self._app_window
        win.bind(on_keyboard=self._key_handler)

    def _key_handler(self, *args):
        key = args[1]
        if key in (1000, 27):
            try:
                sm.current_screen.dispatch("on_back_pressed")
            except Exception as e:
                print(str(e))
                toast(str(e))
            return True
        elif key == 1001:
            try:
                sm.current_screen.dispatch("on_menu_pressed")
            except Exception as e:
                print(str(e))
                toast(str(e))
        return True

    
        

if __name__ == "__main__":
    UI().run()
