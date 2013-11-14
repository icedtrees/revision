<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Template</title>
<link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<style type="text/css">
body,td,th {
	font-family: "Trebuchet MS";
	font-size: 18px;
	margin-left:40px;
	margin-top:40px;
}
</style>
</head>

<body>
<p>This is a weighted graph, and we want to find a spanning tree from $start using Dijkstra's algorithm.</p>
<p>&nbsp;</p>
<img src="$imageRef" />
<p>&nbsp;</p>
<p>$resultMessage</p>
<form role="form">
<div class="form-group">
<p>What is the next connection to be made in the graph?</p>
<p>
  <input type="text" name="nextConnection" />
<input type="hidden" name="graphDetails" value="$graphDetails" />
</p>
</div>
</form>
</body>
</html>
