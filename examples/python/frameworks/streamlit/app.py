import streamlit as st

# Text / Title
st.title("Streamlt Tutorial")

# Header/Subheader
st.header("This is a header")
st.subheader("This is a subheader")

# Text
st.text("Hello streamlit")

# Markdown
st.markdown("### This is a Markdown")

# Error/Colourful text
st.success("Successful!")
st.info("Information!")
st.warning("This is a warning!")
st.error("This is am error message!")

st.exception("NameError('name \"three\" not defined')")

# Get Help for any function in Python
st.help(range)

# Writing text/Super Functions
st.write("Text with write")
st.write(range(10))

# Images
from PIL import Image
img = Image.open("example.jpg")
st.image(img, width=300,caption="Simple Image")

# Videos
# Download an mp4 video in this folder and call it example.mp4
# vid_file = open("example.mp4", "rb").read()
# st.video(vid_file, format="video/mp4")

# Audio
audio_file = open("example.mp3", "rb").read()
st.audio(audio_file, format="audio/mp3")


# Widget

## Checkbox
if st.checkbox("Show/Hide"):
	st.text("Showing or Hiding Widget")

## Radio
status = st.radio("What is your status", ("Active", "Inactive"))

if status == 'Active':
	st.success("You are active")
else:
	st.success("Inactive, Activate")

# SelectBox
occupation = st.selectbox("Your occupation", ["Programmer", "Developer"])
st.write("You have selected this option", occupation)

# MultiSelect
location = st.multiselect("Where do you work?", ("London", "New York", "Paris", "Keiv", "Nepal"))
st.write("You selected", len(location), "locations")

# Slider
level = st.slider("What is your level?", 1, 5, 3)

# Buttons
if st.button("About"):
	st.text("Streamlit is cool")

# Text Input
firstname = st.text_input("Enter your name:", "Type here...")
if st.button("Submit"):
	result = firstname.title()
	st.success(result)

# Text Area
message = st.text_area("Enter your message:", "Type here...")
if st.button("Submit", key="unique"):
	result = message.title()
	st.success(result)

# Date Input
import datetime
today = st.date_input("Today is", datetime.datetime.now())

# Time 
the_time = st.time_input("Time is", datetime.time())

# Display JSON
st.text("Display JSON")
st.json({'a':2, 'b':5})

# Display raw code
st.text("Display raw code")
st.code("import numpy as np")

# Display raw code
with st.echo():
	# this will also show as a comment
	import pandas as pd
	df = pd.DataFrame()


# Progress Bar
import time
my_bar = st.progress(0)
for p in range(10):
	my_bar.progress(p + 1)

# Spinner
with st.spinner("Waiting..."):
	time.sleep(1)
st.success("Finished")

# Balloons 
st.balloons()

# Sidebars
st.sidebar.header("About")
st.sidebar.text("This is streamlit tutorial")

# Functions
@st.cache
def run_multiple():
	return range(100)
st.write(run_multiple())

# Plot
st.pyplot()

# DataFrames
st.dataframe(df)

# Tables
st.table(df)