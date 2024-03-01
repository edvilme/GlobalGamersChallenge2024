import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:trash_game/main.dart';
import 'package:trash_game/trashitem.dart';

class Trashcan extends SpriteComponent with HasGameRef<TrashGame>, CollisionCallbacks {
  late String? type;
  late Function? onSameTypeTrashItemCollision;
  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite("trashcan_$type.png");
    size = Vector2.all(gameRef.size.x/5);
    priority = 2;
    anchor = Anchor.center;
    add(RectangleHitbox());
    // debugMode = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is TrashItem) {
      if (other.type == type) gameRef.addScore();
    }
  }
}