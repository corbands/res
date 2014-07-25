// processing activation 
var bound = false;
var started = false;
var paused = false;
var qsort_canvas_showed = false;

function activate_processing()
{
	pjs = Processing.getInstanceById('qsort');
	if (pjs != null)
	{
		bound = true;

		Processing.logger = console;
		draw_start_configuration();
	}
	if (!bound)
		setTimeout(activate_processing, 10);
}

function draw_start_configuration()
{		
	pjs.draw_start_configuration();	
	pjs.draw();
}

// handlers	
function on_start()
{
	if (!started)
	{
		pjs.start_sort();
		started = true;
		document.getElementById('btn_start').innerHTML = '<span class="glyphicon glyphicon-pause"></span>';
	}
	else
	{
		var start_btn = document.getElementById('btn_start');
		if (!paused)
		{
			paused = true;
			start_btn.innerHTML = '<span class="glyphicon glyphicon-play"></span>';
			pjs.stop_loop();
		}
		else
		{
			paused = false;
			start_btn.innerHTML = '<span class="glyphicon glyphicon-pause"></span>';
			pjs.run_loop();
		}
	}
}

function on_refresh()
{
	started = false;
	document.getElementById('btn_start').innerHTML = '<span class="glyphicon glyphicon-play"></span>';
	draw_start_configuration();
}

function on_plus()
{
	if (qsort_canvas_showed)
	{
		qsort_canvas_showed	= false;
		document.getElementById('btn_plus').innerHTML = '<span class="glyphicon glyphicon-plus"></span>';
	}
	else
	{
		qsort_canvas_showed = true;
		document.getElementById('btn_plus').innerHTML = '<span class="glyphicon glyphicon-minus"></span>';
		pageScroll();
	}
	$('#qsort_canvas').toggle('slow', stopScroll);
}

function pageScroll() {
    	window.scrollBy(0,50); // horizontal and vertical scroll increments
    	scrolldelay = setTimeout('pageScroll()', 30); // scrolls every 100 milliseconds
}

function stopScroll() {
    	clearTimeout(scrolldelay);
}

activate_processing();