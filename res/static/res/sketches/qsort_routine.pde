ArrayList<SortCapture> make_captures(SortElement[] elems)
{
	SortCapture[] captures = new ArrayList<SortCapture>();

	qsort(elems, 0, elems.length - 1, captures);

	return captures;
}

void qsort(SortElement[] elems, int p, int q, ArrayList<SortCapture> captures)
{	
	SortElement[] e = elems;

	int pivot_index = parseInt((p+q)/2);
	int pivot = e[pivot_index].value;	
	int i = p;
	int j = q;

	while (i <= j)
	{	
		while (e[i].value < pivot)
		{	
			//draw_capture(elems, i, j, pivot_index, 1000);
			++i;
		}
		while (e[j].value > pivot)
		{	
			//draw_capture(elems, i, j, pivot_index, 1000);	
			--j;
		}

		if (i <= j)
		{	
			if (i < j)
			{
				e[j].set_destination(e[i].x, e[i].y, -1);
				e[i].set_destination(e[j].x, e[j].y, 1);
				exchange_elements(e, i, j, pivot_index, captures);
			}

			SortElement temp = e[j];
			e[j] = e[i];
			e[i] = temp;
			++i;
			--j;			
		}
	}
	
	if (i < q)
		qsort(e, i, q, captures);
	if (p < j)
		qsort(e, p, j, captures);

}

void exchange_elements(SortElement[] elems, int i, int j, int pivot_index, ArrayList<SortCapture> captures)
{
	boolean stop_moving = false;
	while (!stop_moving)
	{		
		SortCapture cap = new SortCapture(elems, i, j, pivot_index);
		captures.add(cap);		

		boolean b1 = elems[i].move();
		boolean b2 = elems[j].move();


		if (!b1 && !b2)
		{
			stop_moving = true;
		}		
	}
}

//----------------------------------------------//
// classes
//----------------------------------------------//
class SortElement
{
	float x;
	float y;
	int r;
	int value;
	MoveManager mm;

	void init()
	{
		mm = new MoveManager(this);
	}

	SortElement(float x, float y, int r, int value)
	{
		this.x = x;
		this.y = y;
		this.r = r;
		this.value = value;
	}

	void set_destination(float xd, float yd, int dir)
	{
		mm.set_destination(x, y, xd, yd, dir);
	}

	boolean move()
	{
		return mm.move();
	}
}

class MoveManager
{
	SortElement elem;
	float x0;
	float y0;
	float xd;
	float yd;
	int dir;
	int state;

	MoveManager(SortElement elem)
	{
		this.elem = elem;
	}

	void set_destination(float x0, float y0, float xd, float yd, int dir)
	{		
		this.x0 = x0;
		this.y0 = y0;
		this.xd = xd;
		this.yd = yd;
		this.dir = dir;
		state = 0;				
	}

	boolean move()
	{		
		if (dir == 1)
			return move_forward();
		else if (dir == -1)
			return move_backward();

		return true;
	}

	boolean move_forward()
	{		
		float x_dest = xd;
		float y_dest = yd;
		if (x0 == x_dest)
		{
			return false;
		}

		boolean ret = true;
		int r = elem.r;
		switch (state)
		{
		case 0:
			elem.y += r/10.0;
			elem.x += r/15.0;
			if (elem.y >= y0 + r*3/2)
				state = 1;
			break;
		case 1:
			elem.x += r/10.0;	
			if (elem.x > x_dest - r)
				state = 2;
			break;
		case 2:
			elem.x += r/15.0;
			elem.y -= r/10.0;
			if (elem.x >= x_dest - r/1000 && elem.y <= y_dest + r/1000)
				state = 3;

			break;
		case 3:
			ret = false;
			break;
		}

		return ret;
	}

	boolean move_backward()
	{		
		float x_dest = xd;
		float y_dest = yd;

		if (x0 == x_dest)
		{
		    return false;
		}
		    
		boolean ret = true;
		int r = elem.r;
		switch (state)
		{
		case 0:
			elem.y -= r/10.0;
			elem.x -= r/15.0;
			if (elem.y <= y0 - r*3/2)			
				state = 1;
			
			break;
		case 1:
			elem.x -= r/10.0;
			if (elem.x < x_dest + r)
				state = 2;
			break;
		case 2:
			elem.x -= r/15.0;
			elem.y += r/10.0;
			if (elem.x <= x_dest + r/1000 && elem.y >= y_dest - r/1000)
				state = 3;

			break;
		case 3	:
			ret = false;
			break;
		}

		return ret;
	}
}