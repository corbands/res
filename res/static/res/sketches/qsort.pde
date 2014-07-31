Params params;
Sorter sorter;

void setup()
{
	background(#ffffff);
	
	params = new Params(640, 120);

	size(params.width, params.height);

	sorter = new Sorter();

	noLoop();
}


void draw_start_configuration()
{ 
	sorter.clear();
    params.elems = init_sort_elems();
   
    background(#ffffff);
   	for (int i=0; i < params.elems.length; ++i)
   	{
		SortElement e = params.elems[i];
		draw_sort_element(e);
   	}
}

void run_loop()
{
	loop();
}

void stop_loop()
{
	noLoop();
}

void start_sort()
{
	sorter.captures = make_captures(params.elems);			
	loop();
}

void draw()
{
	SortCapture capture = sorter.get_capture();
	if (!capture)
	{
		noLoop();
		return;
	}

	background(#ffffff);

	for (int i=0; i < capture.elems.length; ++i)
	{
		SortElement e = capture.elems[i];
		draw_sort_element(e);
	}
}

//----------------------------------------------//
// helpers
//----------------------------------------------//
SortElement[] init_sort_elems()
{
	int[] arr = new int[10];
	for (int i=0; i < arr.length; ++i)
		arr[i] = int(random(99));

	SortElement[] elems = new SortElement[arr.length];

	int r = 25;
	float y = 60.0;

	int w = params.width;
	float diff = (w*3/4 - r*(2*arr.length-1)) / 2;
	float x = w/8 + diff;

	for (int i=0; i < arr.length; ++i)
	{
		SortElement se = new SortElement(x, y, r, arr[i]);
		se.init();
		x += 2*r;		

		elems[i] = se;
	}      
	return elems;
}

void draw_sort_element(SortElement e)
{
	fill(#ffffff);
    stroke(#dd0000);
    ellipse(e.x, e.y, e.r, e.r);


	fill(0, 0, 0);
	if (e.value > 9)
   		text(str(e.value), e.x-7, e.y+4);
   	else
   		text(str(e.value), e.x-3, e.y+4);
}
//----------------------------------------------//
// classes
//----------------------------------------------//
class Sorter
{
	ArrayList<SortCapture> captures = new ArrayList<SortCapture>();

	int current_capture = 0;		// iterator must be here

	SortCapture get_capture()
	{		
		if (current_capture >= captures.size())	
			return null;

		return captures.get(current_capture++);
	}

	void clear()
	{
		captures.clear();
		current_capture = 0;
	}
}


class SortCapture
{
	SortElement[] elems;
	int i;
	int j;
	int pivot_index;

	SortCapture(SortElement[] elems, int i, int j, int pivot_index)
	{
		this.elems = new SortElement[elems.length];
		for (int k=0; k < elems.length; ++k)
		{
			SortElement e = elems[k];
			this.elems[k] = new SortElement(e.x, e.y, e.r, e.value);
		}

		this.i = i;
		this.j = j;		
		this.pivot_index = pivot_index;

	}
}


class Params
{
	int width;
	int height;
	SortElement[] elems;	// start config

	Params(int w, int h)
	{
		width = w;
		height = h;
	}
}

