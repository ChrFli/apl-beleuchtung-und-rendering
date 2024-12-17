shader_type canvas_item;

void vertex() {
	//VERTEX.x += cos(TIME + VERTEX.x +VERTEX.y);
	VERTEX.y += sin(TIME + VERTEX.y + VERTEX.x) * 20.0;
	VERTEX.x +=sin(sin(TIME * VERTEX.x ));
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
