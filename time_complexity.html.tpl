<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Introduction to Time Complexity</title>
<link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<link href="../../prettify/prettify.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../../prettify/prettify.js"></script>
<style type="text/css">
body,td,th {
	font-family: "Trebuchet MS";
	font-size: 18px;
	margin-left:40px;
	margin-top:40px;
}
</style>
</head>

<body onload=prettyPrint()>
<h3>Introduction to Time Complexity</h3>
<p>The basic idea behind time complexity is that you can figure out how long a certain piece of code will take to run, on average, as some number &quot;n&quot; changes.</p>
<p>&nbsp;</p>
<p>Suppose you have this C program:</p>
<pre class="prettyprint">
int main(int argc, char *argv[]) {
    print(&quot;Hello World!\n&quot;);
}
</pre>
<p>And, of course, it would take a different amount of time to run on every machine, but suppose we have a machine that runs this code in 0.1 seconds. (really slow, I know)</p>
<p>&nbsp;</p>
<p>So now that we know that:</p>
<pre class="prettyprint">
int main(int argc, char *argv[]) {
    int i;
    for (i = 0; i &lt; 100; i ++) { // loop executes 100 times
        print(&quot;Hello World!\n&quot;);
    }
}
</pre>
<p>How long would this take to run on the same machine? 100 * 0.1 = 10 seconds, of course. In the end, 10 seconds is just approximate, but we don't really care if it's 9.8 or 10.2 seconds, really.</p>
<p>Simple, right?</p>
<p>&nbsp;</p>
<pre class="prettyprint">
int main(int argc, char *argv[]) {
    int i;
    int numberPrints;
    scanf(&quot;%d&quot;, &amp;numberPrints);
    for (i = 0; i &lt; numberPrints; i ++) { // loop executes (numberPrints) times
        print(&quot;Hello World!\n&quot;);
    }
}
</pre>
<p>This one gets input from the user.</p>
<p>&nbsp;</p>
<p>Hopefully this one is easy as well. (0.1 * numberPrints) seconds!</p>
<p>&nbsp;</p>
<p>So how does this relate to time complexity? So basically we select a variable &quot;n&quot; and we want to know how the running time of the program changes with &quot;n&quot;. So we choose &quot;n&quot; as &quot;numberPrints&quot; - how many times the print statement executes.</p>
<p>&nbsp;</p>
<p>And it's pretty obvious that we can get the running time with (runtime of print statement) * (numberPrints). Or alternatively, n*k or kn where k is some constant.</p>
<p>&nbsp;</p>
<p>We call this O(n), or &quot;order n&quot; time complexity. All running times are generally in the format k * f(n), and we write this as O(f(n)). </p>
<p>&nbsp;</p>
<p>Some examples of common time complexities:</p>
<div class="alert alert-info">
  <p>O(1) aka &quot;constant time: T = k</p>
<p>O(log(n)) aka &quot;logarithmic time&quot;: T = k * log(n)</p>
<p>O(n) aka &quot;linear time&quot;: T = k * n</p>
<p>O(n*log(n)) aka &quot;nlogn&quot;: T = k * n*log(n)</p>
<p>O(n<sup>2</sup>) aka &quot;quadratic time&quot;: T = k * n<sup>2</sup></p>
<p>O(n<sup>a</sup>) aka &quot;polynomial time&quot;: T = k * n<sup>a</sup></p>
<p>O(a<sup>n</sup>) aka &quot;exponential time&quot;: T = k * a<sup>n</sup></p>
</div>
<p>&nbsp;</p>
<p>The first and second programs (printing once and printing 100 times) had time complexities of O(1), because they always took the same time to run - it didn't change based on n or any other variables</p>
<p>&nbsp;</p>
<div class="alert-info">
  <p><strong>Important: In sorting algorithms, n is the amount of items you are sorting. You want to know how long the sort will take to finish.</strong></p>
  <p>Sometimes there is an extra variable, m, which is the length of the string, if you're sorting strings.</p>
</div>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>Here is a more complex program. What is the time complexity of this program?</p>
<pre class="prettyprint">
int main(int argc, char *argv[]) {
    int i, j;
    int numberPrints;
    scanf(&quot;%d&quot;, &amp;numberPrints);
    for (i = 0; i &lt; numberPrints; i ++) { // loop executes (numberPrints) times
        for (j = 0; j &lt; numberPrints; j ++) { // for each outerloop, innerloop executes (numberPrints) times
            print(&quot;Hello World!\n&quot;);            
        }
    }
}</pre>
<p>&nbsp;</p>
<p>Answer:</p>

<p style="color:#FFF">O(n<sup>2</sup>), since the print statements executes (numberPrints)<sup>2</sup> times.</p>

<div>
  <a href="?">
  <button type="button" class="btn btn-success">
    Go back
  </button>
  </a>
</div>
</body>
</html>
