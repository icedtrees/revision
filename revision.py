#!/usr/bin/python2.7

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

# debugging
import cgitb
cgitb.enable()

import os
import cgi
import string
import random
import math
import sys

#print("Content-type: text/plain\n\n")

import pygame
#from pygame import *
#print dir(pygame)

#print("\n\npygamefont\n\n")
#print dir(pygame.font)

#pygame.font.__init__()

class WeightedGraph(object):
    def new_graph(self):
        # dict of (start, end): weight
        graph = {}
        while (len(graph) < 6):
            for start in range(5):
                for end in range(start + 1, 5):
                    if random.randint(0, 2):
                        graph[(start, end)] = random.randint(1, 100)
        return graph

    def graph_details(self): # Converts graph details to string format
        return str([self.connections, self.traversed, self.start])

    def load_details(self, detailString): # Loads all the details
        details = eval(detailString)
        self.connections = details[0]
        self.traversed = details[1]
        self.start = details[2]

    def __init__(self, previousConnections):
        if previousConnections:
            self.load_details(previousConnections)
        else:
            self.connections = self.new_graph()
            self.traversed = [] # format (start, end)
            self.start = random.randint(0, 5)


    def get_position(self, pointIndex): # center is 300, 300, radius is 200
        angle = 2 * math.pi * pointIndex / 5
        xPosition = math.sin(angle) * 200 + 300
        yPosition = math.cos(angle) * 200 + 300
        return (int(xPosition), int(yPosition))

    def add_traversal(self, connection):
        self.traversed.append(connection)

    def next_dijkstra(self):
        stackTrace = [-1] * 5
        distance = [-1] * 5
        distance[self.start] = 0
        for traversal in self.traversed:
            stackTrace[traversal[1]] = traversal[0]
            current = traversal[1]
            totalDistance = 0
            while (current != self.start):
                previousMove = (current, stackTrace[current])
                totalDistance += self.connections[tuple(sorted(previousMove))]
                current = stackTrace[current]
            distance[traversal[1]] = totalDistance
        minPoint, minLength = (-1, -1), 1000
        for start in [point for point in range(5) if distance[point] != -1]: # visited
            for adjacent in range(5):
                key = tuple(sorted((start, adjacent)))
                if (key in self.connections.keys()) and distance[adjacent] == -1: # unvisited
                     if distance[start] + self.connections[key] < minLength:
                        minPoint = key
                        minLength = distance[start] + self.connections[key]

        return minPoint


    def save_graph_image(self): # saves the graph as an image and returns filepath
        return "../../images/dijkstra.png"
        pygame.font.init()
        lengthFont = pygame.font.SysFont("Arial Black", 20)

        surface = pygame.Surface((600, 600)) # margin of 50px on all sides
        surface.fill((255, 255, 255))
        for index in range(5):
            pointPosition = self.get_position(index)
            pygame.draw.circle(surface, (0, 0, 0), pointPosition, 20, 0)
            label = lengthFont.render(str(index), 1, (255, 0, 0))
            surface.blit(label, pointPosition)

        for traversal in self.traversed:
            position0, position1 = self.get_position(traversal[0]), self.get_position(traversal[1])
            pygame.draw.line(surface, (255, 255, 0), position0, position1 , 10)

        for connection in self.connections.keys():
            position0, position1 = self.get_position(connection[0]), self.get_position(connection[1])
            pygame.draw.line(surface, (0, 0, 255), position0, position1 , 5)

        for connection in self.connections.keys():
            position0, position1 = self.get_position(connection[0]), self.get_position(connection[1])
            label = lengthFont.render(str(self.connections[connection]), 1, (0, 0, 0))
            textPosition = [(position0[0] + position1[0]) / 2, (position0[1] + position1[1]) / 2]
            surface.blit(label, textPosition)

        pygame.image.save(surface, "../../images/dijkstra.png")

        return "../../images/dijkstra.png"

    def dijkstra_keys(self, newConnection): # Generates the required dijkstra keys
        if newConnection: # old graph: verify that connection is right
            newConnection = sorted(newConnection)
            if tuple(newConnection) == self.next_dijkstra():
                self.add_traversal(newConnection)
                resultMessage = "Well done! Try the next path"
            else:
                resultMessage = "Sorry, that is not correct."
        else: # new graph
            resultMessage = "Have a go at trying to figure out the next connection!"
        return {"graphDetails": self.graph_details(), "start": self.start, "imageRef": self.save_graph_image(), "resultMessage": resultMessage}


def html_header():
    return "Content-type: text/html\n\n"

def main():
    form = cgi.FieldStorage()
    pageName = "error.html" # default error
    pageKeys = {} # default empty
    if not form.keys():
        pageName = "index.html"
    elif "page" in form.keys(): # specific page req'd
        pageName = form["page"].value + ".html"
    elif "exercise" in form.keys(): # interactive exercise!
        pageName = form["exercise"].value + "_exercise.html"
        if form["exercise"].value == "dijkstra":
            if "graphDetails" in form.keys():
                currentGraph = WeightedGraph(form["graphDetails"].value)
                pageKeys = currentGraph.dijkstra_keys(eval(form["nextConnection"].value))
            else:
                currentGraph = WeightedGraph("")
                pageKeys = currentGraph.dijkstra_keys(())


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
