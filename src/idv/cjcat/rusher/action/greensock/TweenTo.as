package idv.cjcat.rusher.action.greensock
{
  import com.greensock.TweenLite;
  import idv.cjcat.rusher.action.Action;
  
  public class TweenTo extends Action
  {
    private var target_:Object;
    private var duration_:Number;
    
    private var vars_:Object;
    public function get vars():Object { return vars_; }
    public function set vars(value:Object):void
    {
      if (!value) value = {};
      vars_ = value;
    }
    
    public function TweenTo(target:Object = null, duration:Number = 0, vars:Object = null)
    {
      if (vars == null) vars = {};
      this.target_ = target;
      this.duration_ = duration;
      this.vars = vars;
    }
    
    private var time_:Number;
    private var tween_:TweenLite;
    override public function update(dt:Number):void 
    {
      if (!tween_) 
      {
        if (!vars) vars = { };
        vars.paused = true;
        vars.overwrite = false;
        tween_ = TweenLite.to(target_, duration_, vars);
        tween_.renderTime(time_ = 0.0);
        
        onCancelled.addOnce(tween_.kill);
      }
      else
      {
        tween_.renderTime(time_ += dt);
        if (time_ >= duration_) 
        {
          tween_.kill();
          complete();
        }
      }
    }
  }
}