using Godot;
using System;

public partial class MousePoint : Node
{
    public override void _Input(InputEvent @event)
    {
        // Mouse in viewport coordinates.
        if (@event is InputEventMouseButton eventMouseButton)
            GD.Print("Mouse Click/Unclick at: ", eventMouseButton.Position);
        else if (@event is InputEventMouseMotion eventMouseMotion)
        {
            //GD.Print("Mouse Motion at: ", eventMouseMotion.Position);
        }
    }
}
