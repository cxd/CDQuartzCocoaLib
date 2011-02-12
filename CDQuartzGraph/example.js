var layout = {
    
	"layout": "FORCE_DIRECTED",
	
	"nodes": [
			  {
			  "node": "Mammals",
			  "shape": "ELLIPSE",
			  "x": "50.0",
			  "y": "50.0",
			  "width": "100",
			  "height": "50",
			  "color": "rgb(1.0, 1.0, 1.0)",
			  "outlineColor": "rgb(0.0, 0.0, 0.0)" 
			  },
			  
			  {
			  "node": "Whale",
			  "shape": "CURVED_RECT",
			  "x": "150.0",
			  "y": "50.0",
			  "width": "100",
			  "height": "50",
			  "color": "rgb(1.0, 1.0, 1.0)",
			  "outlineColor": "rgb(0.0, 0.0, 0.0)" 
			  },
			  
			  {
			  "node": "Dolphin",
			  "shape": "CURVED_RECT",
			  "x": "150.0",
			  "y": "200.0",
			  "width": "100",
			  "height": "50",
			  "color": "rgb(1.0, 1.0, 1.0)",
			  "outlineColor": "rgb(0.0, 0.0, 0.0)" 
			  },
			  
			  {
			  "node": "Chimpanzee",
			  "shape": "CURVED_RECT",
			  "x": "300.0",
			  "y": "250.0",
			  "width": "100",
			  "height": "50",
			  "color": "rgb(1.0, 1.0, 1.0)",
			  "outlineColor": "rgb(0.0, 0.0, 0.0)" 
			  },

			  {
			  "node": "Human",
			  "shape": "CURVED_RECT",
			  "x": "300.0",
			  "y": "350.0",
			  "width": "100",
			  "height": "50",
			  "color": "rgb(1.0, 1.0, 1.0)",
			  "outlineColor": "rgb(0.0, 0.0, 0.0)" 
			  },

			  {
			  "node": "Sibling",
			  "shape": "CIRCLE",
			  "x": "300.0",
			  "y": "300.0",
			  "width": "50",
			  "height": "50",
			  "color": "rgb(1.0, 1.0, 1.0)",
			  "outlineColor": "rgb(0.0, 0.0, 0.0)" 
			  },
			  
			  {
			  "node": "Birds",
			  "shape": "ELLIPSE",
			  "x": "50.0",
			  "y": "450.0",
			  "width": "100",
			  "height": "50",
			  "color": "rgb(1.0, 1.0, 1.0)",
			  "outlineColor": "rgb(0.0, 0.0, 0.0)" 
			  },
			  
			  {
			  "node": "Parrot",
			  "shape": "ELLIPSE",
			  "x": "200.0",
			  "y": "450.0",
			  "width": "100",
			  "height": "50",
			  "color": "rgb(0.0, 1.0, 1.0)",
			  "outlineColor": "rgb(0.0, 0.0, 0.0)" 
			  },
			  
			  {
			  "node": "Seagull",
			  "shape": "ELLIPSE",
			  "x": "200.0",
			  "y": "550.0",
			  "width": "100",
			  "height": "50",
			  "color": "rgb(1.0, 1.0, 0.0)",
			  "outlineColor": "rgb(0.0, 0.0, 0.0)" 
			  }
			  
			  ],
    "edges": [
			  {
			  "from": "Mammals",
			  "to": "Whale" 
			  },
			  {
			  "from": "Mammals",
			  "to": "Dolphin" 
			  },
			  {
			  "from": "Mammals",
			  "to": "Chimpanzee" 
			  },
			  {
			  "from": "Mammals",
			  "to": "Human" 
			  },
			  {
			  "from": "Human",
			  "to": "Sibling" 
			  },
			  {
			  "from": "Sibling",
			  "to": "Chimpanzee" 
			  },
			  {
			  "from": "Birds",
			  "to": "Parrot" 
			  },
			  {
			  "from": "Birds",
			  "to": "Seagull" 
			  } 
			  ] 
};