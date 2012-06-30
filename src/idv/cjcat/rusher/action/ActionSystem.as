package idv.cjcat.rusher.action 
{
  import idv.cjcat.rusher.data.InList;
  import idv.cjcat.rusher.data.InListIterator;
  import idv.cjcat.rusher.engine.System;
  
  public class ActionSystem extends System
  {
    private var actions_:ActionList = new ActionList(false);
    private var actionComponents_:InList = new InList();
    
    private var initActions_:Array;
    public function ActionSystem(...actions)
    {
      initActions_ = actions;
    }
    
    public function pushBack(action:Action, groupID:int = 0):void
    {
      actions_.pushBack(action, groupID);
    }
    
    public function pushFront(action:Action, groupID:int = 0):void
    {
      actions_.pushFront(action, groupID);
    }
    
    public function register(actionComponent:ActionComponent):void
    {
      actionComponents_.pushBack(actionComponent);
    }
    
    public function unregister(actionComponent:ActionComponent):void
    {
      actionComponents_.remove(actionComponent);
    }
    
    override public function init():void 
    {
      actions_.setInjector(getInjector());
      
      for (var i:int = 0, len:int = initActions_.length; i < len; ++i)
      {
        pushBack(initActions_[i]);
      }
      initActions_ = null;
    }
    
    override public function dispose():void 
    {
      actions_.cancel();
    }
    
    override public function update(dt:Number):void 
    {
      actions_.update(dt);
      
      var comp:ActionComponent;
      var iter:InListIterator = actionComponents_.getIterator();
      while (comp = iter.data())
      {
        comp.update(dt);
        iter.next();
      }
    }
  }
}