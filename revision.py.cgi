#!C:\Python27\python.exe

#-------------------------------------------------------------------------------
# Name:        revision
# Purpose:
#
# Author:      icedtrees
#
# Created:     13/11/2013
# Copyright:   (c) icedtrees 2013
# Licence:     GNU GPL 2.0
#-------------------------------------------------------------------------------

import os
import cgi
import string
import image
import imageDraw

# debugging
import cgitb
cgitb.enable()

def new_graph():
    pass

def add_connection(graph, connection):
    pass

def next_dijkstra(graph):
    pass

def save_graph_image(graph): # saves the graph as an image and returns filepath
    pass

def html_header():
    return "Content-type: text/html\n\n"

def dijkstra_keys(form): # Accepts form params and generates the required dijkstra keys
    if "graphDetails" not in form.keys(): # new graph
        newGraph = new_graph()
        pageKeys = {"graphDetails": newGraph, "start": newGraph[-1], "imageRef": save_graph_image(newGraph)}

    else: # adding a connection!
        currentGraph = form["graphDetails"].value
        userConnection = form["nextConnection"].value
        if userConnection[0] > userConnection[1]: # order it
            userConnection = userConnection[::-1]
        if next_dijkstra(currentGraph) == userConnection:
            nextGraph = add_connection(currentGraph, userConnection)
            save_graph_image(nextGraph)

def main():
    form = cgi.FieldStorage()
    pageName = "error.html" # default error
    pageKeys = {} # default empty
    if not form.keys():
        pageName = "index.html"
    elif "page" in form.keys(): # specific page req'd
        pageName = form["page"].value + ".html"
    elif "exercise" in form.keys(): # interactive exercise!
        pageName = form["page"].value + "_exercise.html"
        if form["page"].value == "dijkstra":
            pageKeys = dijkstra_keys(form)


    # apparently header is required
    print html_header()

    # read the page and print it (if it exists)
    templateName = pageName + ".tpl"
    if templateName not in os.listdir("."):
        pageName = "error.html"

    pageTemplate = string.Template(open(templateName, "r").read())
    print(pageTemplate.substitute(pageKeys))

if __name__ == '__main__':
    main()
