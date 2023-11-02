using Godot;
using System;

public partial class Inputs : Node2D
{
    [Signal]
    public delegate void ImpulsoEventHandler(int impulsoLeft, int impulsoRight, Vector2 posicao);

    (int left, int right, Vector2 posicao) _impulso = (0, 0, new Vector2());

    public override void _Input(InputEvent @event)
    {
        // Mouse in viewport coordinates.
        if (@event is InputEventMouseButton eventMouseButton)
        {
            _impulso.posicao = eventMouseButton.Position;
        }
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
    {
        _impulso = (0, 0, new Vector2());
        if (Input.IsActionPressed("A"))
        {
            _impulso.left = 1;
        }
        if (Input.IsActionPressed("Z"))
        {
            _impulso.left = -1;
        }
        if (Input.IsActionPressed("K"))
        {
            _impulso.right = 1;
        }
        if (Input.IsActionPressed("M"))
        {
            _impulso.right = -1;
        }
        if (Input.IsActionPressed("QUIT"))
        {
            GetTree().Quit();
        }
        EmitSignal(SignalName.Impulso, _impulso.left, _impulso.right);
    }
}
