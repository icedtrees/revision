<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Time Complexity: Dominance and Optimisation</title>
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
<h3>Time Complexity: Dominance and Optimisation</h3>
<p>Now we have a way of categorising C programs into a &quot;time complexity category&quot; based on the code. But that raises two questions:</p>
<ul>
  <li>What happens when you have an improper f(n) for your time complexity? E.g. T = k * (5n + log(n) + 8) + k<sub>2</sub> * (8n + 2)</li>
  <li>Why are we even bothering to categorise programs based on time complexity?</li>
</ul>
<p>&nbsp;</p>
<p>Suppose you code two programs to do the same thing. One runs in time: (k = 0.1)</p>
<span class="alert-info">T<sub>1</sub> = 0.1 * n (O(n))</span>
<p>and the other one runs in time: (k = 0.001)</p>
<span class="alert-info">T<sub>2</sub> = 0.001 * n<sup>2</sup> (O(n<sup>2</sup>))</span>
<p>&nbsp;</p>
<p>Now you could be thinking, which program is better to use? Let's see how long they take to run at different n.</p>
<p>&nbsp;</p>
<div class="alert alert-info">
<p>For n = 1:</p>
<p>T<sub>1</sub> = 0.1s</p>
<p>T<sub>2</sub> = 0.001s</p>
</div>
<p>&nbsp;</p>
<p>Looks like T<sub>2</sub> is 100 times faster! But, honestly, can you tell the difference between 0.1s and 0.001s? I sure as hell can't.
<p style="font-size: 10px">(except when I'm playing dota)</p>
<p>&nbsp;</p>
<div class="alert alert-info">
<p>For n = 10:</p>
<p>T<sub>1</sub> = 1s</p>
<p>T<sub>2</sub> = 0.1s</p>
</div>
<p>&nbsp;</p>
<p>What's this?</p>
<p>&nbsp;</p>
<div class="alert alert-info">
<p>For n = 1000:</p>
<p>T<sub>1</sub> = 100s</p>
<p>T<sub>2</sub> = 1000s</p>
</div>
<p>&nbsp;</p>
<p>I think I can definitely tell the difference between 2 minutes and 20 minutes.</p>
<p>&nbsp;</p>
<p>Do you see what I'm getting at here? We don't care about how fast the programs runs at low numbers, because who's going to care if your program runs 0.09 seconds faster? (Hint: people that care &lt; 1)</p>
<p>&nbsp;</p>
<p>And how the program behaves at large values of n isn't really affected by k. It's more affected by the time complexity, i.e. what f(n) is. Remember the list of time complexities from the Intro?</p>
<p>&nbsp;</p>
<div class="alert alert-info">
  <p>O(1) aka &quot;constant time: T = k</p>
  <p>O(log(n)) aka &quot;logarithmic time&quot;: T = k * log(n)</p>
  <p>O(n) aka &quot;linear time&quot;: T = k * n</p>
  <p>O(n*log(n)) aka &quot;nlogn&quot;: T = k * n*log(n)</p>
  <p>O(n<sup>2</sup>) aka &quot;quadratic time&quot;: T = k * n<sup>2</sup></p>
  <p>O(n<sup>a</sup>) aka &quot;polynomial time&quot;: T = k * n<sup>a</sup></p>
  <p>O(a<sup>n</sup>) aka &quot;exponential time&quot;: T = k * a<sup>n</sup></p>
</div>
<p></p> 
<p>They're actually in a certain order. This order is best performance --&gt; worst performance. O(1) performs the best for large values of n, while O(a<sup>n</sup>)
performs the worst. We can examine the graphs of certain functions:</p>
<p>&nbsp;</p>
<div>
<img src="../../images/running-times.gif" class="img-rounded" width="869" height="620" alt="Congratulations on viewing the alt text!" />
</div>
<p style="font-size: 12px">Credit: <a href="http://science.slc.edu/~jmarshall/courses/2002/spring/cs50/BigO/">http://science.slc.edu/~jmarshall/courses/2002/spring/cs50/BigO/</a></p>
<p>&nbsp;</p>
<p>Now let's write a slightly more complicated program:</p>
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

    for (i = 0; i &lt; numberPrints; i ++) { // loop executes (numberPrints) times
        for (j = 0; j &lt; 100; j ++) { // ONLY 100 TIMES!
            print(&quot;Hello World!\n&quot;);            
        }
    }

}</pre>
<p>So we have T = (k * n<sup>2</sup>) + (k * 100n)</p>
<p>What's the time complexity?</p>
<p>Answer:</p>

<p style="color:#FFF">O(n<sup>2</sup>)), because the first term dominates the second.</p>
<p>&nbsp;</p>
<p>This is because the &quot;more dominating&quot; or &quot;worst performing&quot; part of the time equation becomes increasingly more significant as n becomes large. Say n = 1000, 100n = 100 000 is nothing compared to n<sup>2</sup> = 1 000 000. The n<sup>2</sup> term is taking up over 90% of the total running time - it's the most important one, because it dominates.</p>
<p>&nbsp;</p>
<p>Later we will apply time complexity to sorting algorithms as well! We will find the most time-consuming part of the sort, and use that to derive the time complexity of the sort. We can then use patterns of running time to figure out the sort.</p>
<p>&nbsp;</p>
<div class = "alert alert-info">
<p>Example:</p>
<p>T(10) = 1s, T(100) = 10s, T(1000) = 100s</p>
<p>What's the time complexity?</p>
</div>
<p>We examine the ratio between terms</p>
<p>k*f(1000) / k*f(100) = k*f(100) / k*f(10) = 10</p>
<p>It looks like f(10n) = 10 * f(n)</p>
<p>&nbsp;</p>
<p>Or to explain it in words: if we multiply n by 10, the time taken is multiplied by 10 as well</p>
<p>O(n) aka linear time! (f(n) = k*n)</p>
<p>&nbsp;</p>
<div class = "alert alert-info">
<p>Example 2:</p>
<p>T(10) = 1s, T(100) = 3.2s, T(1000) = 10s</p>
<p>What's the time complexity?</p>
</div>
<p>f(10n) = 3.2 * f(n) (approx)</p>
<p>f(10n) = sqrt(10) * f(n)</p>
<p>&nbsp;</p>
<p>O(sqrt(n))!</p>
<p>If n is multiplied by 10, the time taken is multiplied by sqrt(10)!</p>
<p>We can check this:</p>
<div class="alert alert-info">
<p>f(n) = sqrt(n)</p>
<p>f(10n) = sqrt(10n)</p>
<p>= sqrt(10) * sqrt(n)</p>
</div>
<p>&nbsp;</p>
<div class = "alert alert-info">
<p>Example 3:</p>
<p>T(10) = 1s, T(100) = 4.2s, T(1000) = 7.4s</p>
<p>What's the time complexity?</p>
</div>
<p>This one is a lot harder. But if an algorithm seems better than sqrt(n), there are only two options left!</p>
<p>We observe that f(10n) = f(n) + 3.2</p>
<p>it's O(log(n))!</p>
<p>Demonstrating this:</p>
<div class="alert alert-info">
<p>f(n) = log<sub>a</sub>(n)</p>
<p>f(10n) = log<sub>a</sub>(10n)</p>
<p>= log<sub>a</sub>(10) + log<sub>a</sub>(n)</p>
<p>log<sub>a</sub>(10) = 3.2</p>
<p>a = 2.0 (approx)</p>
</div>
<p>&nbsp;</p>
<p>It looks like our algorithm is O(log<sub>2</sub>(n))! You can tell log algorithms apart by the additive element.</p>
<p>&nbsp;</p>
<p>n*log(n) is even harder than n, but I'll cover that if I ever get to finish writing these damned resources.</p>
<p>&nbsp;</p>

<div>
  <a href="?">
<button type="button" class="btn btn-success">
    Go back
  </button>
  </a>
</div>
</body>
</html>
