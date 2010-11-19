//
//  ForceDirectedLayout.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 5/09/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

#import "ForceDirectedLayout.h"


@implementation ForceDirectedLayout

@synthesize width;
@synthesize height;

/**
 Initialise with prior conditions.
 Width, Height and number of Epochs.
 **/
-(id)initWidth:(float)w Height:(float)h Epochs:(int)e Temperature:(float)t
{
	self = [super init];
	self.width = w;
	self.height = h;
	epochs = e;
	initialTemperature = t;
	return self;
}



-(void)dealloc
{
	[super dealloc];
}


/**
 Perform the layout algorithm on the supplied graph. 
 **/


/**
 This algorithm follows the explanation of the force directed layout from
 
 "The Handbook of Graph Drawing and Visualisation", Robert Tamassia Editor, CRC Press 2010.
 
 A search for the title will produce the following link: http://www.cs.brown.edu/~rt/gdhandbook/
 
 The force directed layout algorithm is described below:
 
 
 area:= W ∗ L; {W and L are the width and length of the frame} 
 
 G := (V, E); {the vertices are assigned random initial positions} 
 k := sqrt(area/|V|);
 
 function fa(x) := begin return x^2/k end;
 function fr(x) := begin return -k^2/x end; 
 
 for i := 1 to iterations do begin
	{calculate repulsive forces} 
	for v in V do begin
	
		{each vertex has two vectors: .pos and .disp 
 
		v.disp := 0; 
 
		for u in V do
			
			if (u != v) then begin 
 
				{δ is the difference vector between the positions of the two vertices } 
				δ := v.pos − u.pos; 
				v.disp := v.disp + (δ/|δ|) ∗ fr (|δ|)
			end
		end
	end
	
	{calculate attractive forces} 
 
	for e in E do begin
		{each edges is an ordered pair of vertices .vand.u} 
		δ := e.v.pos − e.u.pos; 
		e.v.disp := e.v.disp − (δ/|δ|) ∗ fa(|δ|); 
		e.u.disp := e.u.disp + (δ/|δ|) ∗ fa(|δ|);
	end
 
	{limit max displacement to temperature t and prevent from displacement outside frame} 
	
	for v in V do begin
		v.pos := v.pos + (v.disp/|v.disp|) ∗ min(v.disp, t); 
		v.pos.x := min(W/2, max(−W/2, v.pos.x)); 
		v.pos.y := min(L/2, max(−L/2, v.pos.y))
	end
 
	{reduce the temperature as the layout approaches a better configuration} 
	t := cool(t)
 
 end
 **/
-(void)layout:(CDQuartzGraph *)graph
{
	float temperature = initialTemperature;
	dividedArea = (self.width*self.height)/(1.0f*[graph.nodes count]);
	for(int i=0;i<epochs;i++)
	{
		/**
		 {calculate repulsive forces} 
		 for v in V do begin
		 
		 {each vertex has two vectors: .pos and .disp 
		 
		 v.disp := 0; 
		 
		 for u in V do
		 
		 if (u != v) then begin 
		 
		 {δ is the difference vector between the positions of the two vertices } 
		 δ := v.pos − u.pos; 
		 v.disp := v.disp + (δ/|δ|) ∗ fr (|δ|)
		 end
		 end
		 end
		 
		 **/
		for(CDQuartzNode *node1 in graph.nodes)
		{
			if (node1.shapeDelegate == nil)
				continue;
			node1.shapeDelegate.displacement = [[QPoint alloc] init];
			for(CDQuartzNode *node2 in graph.nodes)
			{
				if (node2.shapeDelegate == nil)
					continue;
				if ([node1 isEqual:(id)node2])
					continue;
				
				QPoint *gradient = [[QPoint alloc]
								initX:(node1.shapeDelegate.bounds.x - node2.shapeDelegate.bounds.x)
								Y:node1.shapeDelegate.bounds.y - node2.shapeDelegate.bounds.y];
				
				float magnitude = sqrt(gradient.x*gradient.x + gradient.y*gradient.y);
				if (magnitude == 0.0 || isnan(magnitude))
				{
					magnitude = 1.0;	
				}
				float r = [self repulse:magnitude];
				gradient.x = gradient.x/magnitude;
				gradient.y = gradient.y/magnitude;
				node1.shapeDelegate.displacement.x = node1.shapeDelegate.displacement.x + gradient.x * r;
				node1.shapeDelegate.displacement.y = node1.shapeDelegate.displacement.y + gradient.y * r;
			}
		}		
		/**
		 {calculate attractive forces} 
		 
		 for e in E do begin
		 {each edges is an ordered pair of vertices .vand.u} 
		 δ := e.v.pos − e.u.pos; 
		 e.v.disp := e.v.disp − (δ/|δ|) ∗ fa(|δ|); 
		 e.u.disp := e.u.disp + (δ/|δ|) ∗ fa(|δ|);
		 end
		 
		 **/
		for(CDQuartzEdge *edge in graph.edges)
		{
			if (edge.source == nil)
				continue;
			if (edge.target == nil)
				continue;
			CDQuartzNode *v = (CDQuartzNode *)edge.source;
			CDQuartzNode *u = (CDQuartzNode *)edge.target;
			if (v.shapeDelegate == nil || u.shapeDelegate == nil)
				continue;
			QPoint *gradient = [[QPoint alloc] initX: v.shapeDelegate.bounds.x - u.shapeDelegate.bounds.x
												   Y: v.shapeDelegate.bounds.y - u.shapeDelegate.bounds.y];
			float magnitude = sqrt(gradient.x*gradient.x + gradient.y*gradient.y);
			if (magnitude == 0 || isnan(magnitude))
			{
				magnitude = 1.0;	
			}
			float a = [self attract:magnitude];
			gradient.x = gradient.x/magnitude;
			gradient.y = gradient.y/magnitude;
			v.shapeDelegate.displacement.x = v.shapeDelegate.displacement.x + gradient.x * a;
			v.shapeDelegate.displacement.y = v.shapeDelegate.displacement.y + gradient.y * a;
			u.shapeDelegate.displacement.x = u.shapeDelegate.displacement.x + gradient.x * a;
			u.shapeDelegate.displacement.y = u.shapeDelegate.displacement.y + gradient.y * a;
		}
		
		/**
		 {limit max displacement to temperature t and prevent from displacement outside frame} 
		 
		 for v in V do begin
		 v.pos := v.pos + (v.disp/|v.disp|) ∗ min(v.disp, t); 
		 v.pos.x := min(W/2, max(−W/2, v.pos.x)); 
		 v.pos.y := min(L/2, max(−L/2, v.pos.y))
		 end
		 **/
		for(CDQuartzNode *node in graph.nodes)
		{
			if (node.shapeDelegate == nil)
				continue;
			QPoint *d = node.shapeDelegate.displacement;
			QPoint *p = [[QPoint alloc] initX: node.shapeDelegate.bounds.x Y: node.shapeDelegate.bounds.y];
			float magnitude = sqrt(d.x*d.x + d.y*d.y);
			if (magnitude == 0 || isnan(magnitude))
			{
				magnitude = 1.0;	
			}
			d.x = d.x/magnitude;
			d.y = d.y/magnitude;
			p.x = p.x + d.x * [self min:d.x And:temperature];
			p.y = p.y + d.y * [self min:d.y And:temperature];
			p.x = [self min: (width/1.5f)
						And: [self max:-1.0*(self.width/2.0) And:p.x]];
			p.y = [self min: (height/1.5f)
						And: [self max:-1.0*(self.height/2.0) And:p.y]];
			
			[graph moveNode:node To:p];
		}
		// cool the initial temperature.
		temperature =  temperature * (1.0 - i + 1.0) / (epochs - 1.0);
	}
}

/**
 The minimum of two values.
 **/
-(float)min:(float)a And:(float)b
{
	if (a <= b) return a;
	else return b;
}

/**
 The maximum of two values.
 **/
-(float)max:(float)a And:(float)b
{
	if (a >= b) return a;
	else return b;
}

/**
 Calculate the attractive force
 **/
-(float)attract:(float)dist
{
	return (dist*dist)/dividedArea;
}

/**
 Calculate the repulsive force.
 **/
-(float)repulse:(float)dist
{
	return -1.0*(dividedArea*dividedArea)/dist;	
}


@end
