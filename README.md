XBlaster
========

Update
========
2014/12/10

建立了一個可以發射的飛艇, 用 ▲ 符號當基座, 用 < > 當機翼, 好像是位置的原因, 機翼轉了180°. 要寫一段背景的 SKNode 加上背景顏色來確認一下是怎麼回事.

```swift
let mainShip = SKLabelNode(fontNamed: "Arial")
mainShip.name = "mainship"
mainShip.fontSize = 40
mainShip.fontColor = SKColor.whiteColor()
mainShip.text = "▲"

let wings = SKLabelNode(fontNamed: "Arial")
wings.name = "wings"
wings.fontSize = 40
wings.text = "< >"
wings.fontColor = SKColor.whiteColor()
wings.position = CGPoint(x: 1, y: 7)

wings.zRotation = CGFloat(180).degreesToRadians()
mainShip.addChild(wings)
```

下面這一段是 cannon 火箭砲, 看不太懂 dispatch_once 是啥意思

```swift
dispatch_once(&SharedTexture.onceToken, {
    let cannon = SKLabelNode(fontNamed: "Arial")
    cannon.name = "bullet"
    cannon.fontSize = 40
    cannon.fontColor = SKColor.whiteColor()
    cannon.text = "•"
    
    let textureView = SKView()
    SharedTexture.texture = textureView.textureFromNode(cannon)
    SharedTexture.texture.filteringMode = .Nearest
})
```

加上去後, ⌘ R 就可以看到移動的飛艇和不斷發射的火箭砲了XD. 講真的, 目前還是照抄, 要真的熟, 得要自己重新重無到有照寫一次才是真的自己的 


Resource
========
Font from www.dafont.com [edit_undo_line](http://www.dafont.com/search.php?q=Edit+Undo+Line)

Good to Read
============
Introduction to Component Based Architecture in Games (http://www.raywenderlich.com/24878/introduction-to-component-based-architecture-in-games)
