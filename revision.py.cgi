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
import pygame
import random

# debugging
import cgitb
cgitb.enable()

class WeightedGraph(object):
    def new_graph(self):
        # dict of (start, end): weight
        graph = {}
        for start in range(9):
            for end in range(start + 1, 9):
                if random.randint(0, 2) == 0:
                    graph[(start, end)] = random.randint(1, 100)
        return graph

    def get_position(self, pointIndex):
        return (100 + (pointIndex / 3) * 200, 100 + (pointIndex % 3) * 200)

    def __init__(self):
        self.connections = self.new_graph()
        self.traversed = [] # format (start, end)
        self.start = random.randint(0, 8)

    def add_traversal(self, connection):
        self.traversed.append(connection)

    def next_dijkstra(graph):
        for traversal in self.traversed:
            pass


    def save_graph_image(self): # saves the graph as an image and returns filepath
        surface = pygame.Surface((600, 600)) # margin of 50px on all sides
        surface.fill((255, 255, 255))
        for index in range(9):
            pygame.draw.circle(surface, (0, 0, 0), self.get_position(index), 20, 0)
        pygame.font.init()
        lengthFont = pygame.font.SysFont("monospace", 15)
        for connection in self.connections.keys():
            position0, position1 = self.get_position(connection[0]), self.get_position(connection[1])
            pygame.draw.line(surface, (0, 0, 255), position0, position1 , 5)
            label = lengthFont.render(str(self.connections[connection]), 1, (0, 0, 0))
            surface.blit(label, ((position0[0] + position1[0]) / 2, (position0[1] + position1[1]) / 2))

        pygame.image.save(surface, "dijkstra.png")

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
    # main()
    graph = WeightedGraph()
    graph.save_graph_image()
