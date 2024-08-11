GDPC                �                                                                         T   res://.godot/exported/133200997/export-33e29fa2f2bb68ceed4cd1a3a579b7ea-Fighter.scn         �      ��'����\����Ir    T   res://.godot/exported/133200997/export-76b8bc62749e8cf48c832874a4449e21-Level1.scn  �      �	      xuW�^#<Ԣ���w    ,   res://.godot/global_script_class_cache.cfg   X             ��Р�8���8~$}P�    H   res://.godot/imported/Nimetön.png-b84a16d0c6a211d1f077f241fd503bd4.ctex�S      �      �YA��)�ELy�	r�    H   res://.godot/imported/hex_grid.png-3c8ae0c01c0cb53179044f008dbae01f.ctex .      �      �]ۥM���c��s�e�L    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�E            ：Qt�E�cO���       res://.godot/uid_cache.bin  �[      �       Ĥ��̣K,�������       res://Fighter.gd W              ��ُ ��	���B~       res://Fighters/Fighter.gd   �      �       e���3����������    $   res://Fighters/Fighter.tscn.remap    W      d       �/�����WJ/���N        res://Levels/Level1.tscn.remap  �W      c       A%dhnO�'5�� WT       res://Levels/TileMap.gd �      z       �q���JF�* �8\       res://Nimetön.png.import   PV      �       z!�ݝ���/�����o)       res://hex_grid.png.import   E      �       Ǖ�@zx�W�D�       res://icon.svg   X      �      k����X3Y���f       res://icon.svg.import    S      �       �]�٩�x~�0�5�6�       res://project.binary�\      2      ����֌'�h�__6�v�        RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script    
   Texture2D    res://Nimetön.png ���
C�\h   Script    res://Fighters/Fighter.gd ��������      local://PackedScene_18vl1 >         PackedScene          	         names "         Node2D 	   Sprite2D    texture    script    	   variants                                node_count             nodes        ��������        ����                      ����                          conn_count              conns               node_paths              editable_instances              version             RSRCextends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
               RSRC                    PackedScene            ��������                                            "      resource_local_to_scene    resource_name    texture    margins    separation    texture_region_size    use_texture_padding    0:0/next_alternative_id    0:0/0    0:0/0/modulate    0:0/0/script    0:0/1    0:0/1/script    1:0/next_alternative_id    1:0/0    1:0/0/modulate    1:0/0/script    1:0/1    1:0/1/script    2:0/0    2:0/0/script    0:1/0    0:1/0/script    script    tile_shape    tile_layout    tile_offset_axis 
   tile_size    uv_clipping 
   sources/0    tile_proxies/source_level    tile_proxies/coords_level    tile_proxies/alternative_level 	   _bundled    
   Texture2D    res://hex_grid.png |�Bj�~h0   Script    res://Levels/TileMap.gd ��������   PackedScene    res://Fighters/Fighter.tscn `J�%   !   local://TileSetAtlasSource_yi3gp �         local://TileSet_adq84 �         local://PackedScene_ww6ai L         TileSetAtlasSource                    -   	         -             -   n   `                      	      ��?��?��?  �?
                                              ��?��?��?  �?                                                              TileSet                         -   f   ^                         PackedScene    !      	         names "         Node2D    TileMap 	   tile_set    format    layer_0/tile_data    script    Fighter    	   variants                          �                                                                                                                                                                                                                                                                                                                                                      	         
         	                                    	         
                   	         
         
         
         	                                  node_count             nodes        ��������        ����                      ����                                       ���                    conn_count              conns               node_paths              editable_instances              version             RSRC     extends TileMap

const main_layer = 0
const main_atlas_id = 0

const tolerance = 0.01    #rotation angle tolerance

@onready var fighter = $Fighter  # Ensure this node exists and is correctly referenced

var target_position = Vector2()  # The position to which the sprite will move
var fighter_moving = false  # Flag to track if the sprite is moving


func _ready():
	if fighter:
		var starting_position = Vector2(1,2) 
		var new_position = map_to_local(starting_position)  # Convert tile coordinate to world coordinate
		fighter.position = new_position  # Move the fighter to the world position
		
		_movefighter(starting_position)  # Calls the function with tile coordinates [3,1]
		starting_position.x += 1
		set_cell(main_layer, starting_position, main_atlas_id, get_cell_atlas_coords(main_layer, starting_position), 1)
		starting_position.y += 1
		set_cell(main_layer, starting_position, main_atlas_id, get_cell_atlas_coords(main_layer, starting_position), 1)
	else:
		print("Fighter node not found")

func _process(delta):
	if fighter_moving:
		# Move the fighter towards the target position
		var movement = (target_position - fighter.position).normalized() * 200 * delta  # Speed of 200 units per second
		fighter.position += movement
		
		# Stop moving if the fighter is close enough to the target position
		if (target_position - fighter.position).length() < 1:
			fighter.position = target_position  # Snap to the target position
			fighter_moving = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and fighter_moving == false:
			var global_clicked = event.position
			var pos_clicked = local_to_map(to_local(global_clicked))
			print(pos_clicked)
			# var current_atlas_coords = get_cell_atlas_coords(main_layer, pos_clicked)
			# If manual alternative tile clicking is needed:
			# var current_tile_alt = get_cell_alternative_tile(main_layer, pos_clicked)
			# var number_of_alts_for_clicked = tile_set.get_source(main_atlas_id).get_alternative_tiles_count(current_atlas_coords)
			# set_cell(main_layer, pos_clicked, main_atlas_id, current_atlas_coords, (current_tile_alt +1 ) % number_of_alts_for_clicked)
			var world_position_clicked = map_to_local(pos_clicked)
			print("World coordinates for the clicked tile: ", world_position_clicked)
			print("fighter rotation: ", fighter.rotation)
			
			var current_tile_alt = get_cell_alternative_tile(main_layer, pos_clicked)
			if current_tile_alt == 1:
				
				
				if fighter:	
					_movefighter(pos_clicked)
				else:
					print("Fighter node not found")
			else:
				print("The alternative tile index is not 1.")
				
func _movefighter(tilepos: Vector2):
		var tile_coordinate = Vector2(tilepos)  # Tile coordinate you want to place the fighter at
		var new_position = map_to_local(tile_coordinate)  # Convert tile coordinate to world coordinate
		#fighter.position = new_position  # Move the fighter to the world position
		target_position = map_to_local(tilepos)  # Convert tile position to world coordinates
		fighter_moving = true
		var direction = (target_position - fighter.position).normalized()
		# Set the fighter's rotation to face the target position
		fighter.rotation = direction.angle()
		
		set_all_tiles_to_alternative(0)  # Set all tiles to alternative index 0
		
		if fighter.rotation == 0: # right
			#set alternatives for future movements
			tilepos.x += 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			#checking if x is even (because of hex tiles)
			if abs(tilepos.x - round(tilepos.x)) < 0.00001 and int(tilepos.x) % 2 == 0:
				tilepos.y += 1
			else:
				tilepos.y -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
		if abs(fighter.rotation - 0.55) < tolerance:   # down right
			#set alternatives for future movements
			tilepos.y += 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			tilepos.y -= 1
			
			tilepos.x += 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			#checking if x is even (because of hex tiles)
			if abs(tilepos.x - round(tilepos.x)) < 0.00001 and int(tilepos.x) % 2 == 0:
				tilepos.y += 1
			else:
				tilepos.y -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
		if abs(fighter.rotation - 2.59) < tolerance:   # down left
			#set alternatives for future movements
			tilepos.y += 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			tilepos.y -= 1
			
			tilepos.x -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			#checking if x is even (because of hex tiles)
			if abs(tilepos.x - round(tilepos.x)) < 0.00001 and int(tilepos.x) % 2 == 0:
				tilepos.y += 1
			else:
				tilepos.y -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
		if abs(fighter.rotation - -0.55) < tolerance:   # up right
			#set alternatives for future movements
			tilepos.y -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			tilepos.y += 1
			
			tilepos.x += 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			#checking if x is even (because of hex tiles)
			if abs(tilepos.x - round(tilepos.x)) < 0.00001 and int(tilepos.x) % 2 == 0:
				tilepos.y += 1
			else:
				tilepos.y -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
		if abs(fighter.rotation - -2.59) < tolerance:   # up left
			#set alternatives for future movements
			tilepos.y -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			tilepos.y += 1
			
			tilepos.x -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			#checking if x is even (because of hex tiles)
			if abs(tilepos.x - round(tilepos.x)) < 0.00001 and int(tilepos.x) % 2 == 0:
				tilepos.y += 1
			else:
				tilepos.y -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
		
		if abs(fighter.rotation - 1.57) < tolerance:   # down
			#set alternatives for future movements
			tilepos.y += 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			tilepos.x +=1
			if abs(tilepos.x - round(tilepos.x)) < 0.00001 and int(tilepos.x) % 2 == 0:
				tilepos.y == 1
			else:
				tilepos.y -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			tilepos.x -=2
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			
		if abs(fighter.rotation - -1.57) < tolerance:   # up
			#set alternatives for future movements
			tilepos.y -= 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			tilepos.x +=1
			if abs(tilepos.x - round(tilepos.x)) < 0.00001 and int(tilepos.x) % 2 == 0:
				tilepos.y += 1
			else:
				tilepos.y == 1
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
			
			tilepos.x -=2
			set_cell(main_layer, tilepos, main_atlas_id, get_cell_atlas_coords(main_layer, tilepos), 1)
		
func set_all_tiles_to_alternative(alternative_index: int):
	# Get the size of the TileMap
	var map_size = get_used_rect().size
	var map_width = int(map_size.x)
	var map_height = int(map_size.y)
	
	# Iterate through all cells in the TileMap
	for x in range(map_width+1):
		for y in range(map_height):
			var tile_position = Vector2(x, y)
			
			# Get the current tile ID at the position
			var tile_id = get_cell_alternative_tile(main_layer, tile_position)
			
			if tile_id != -1:  # Check if there's a valid tile ID at the position
				# Set the alternative index for the tile
				set_cell(main_layer, tile_position, main_atlas_id, get_cell_atlas_coords(main_layer, tile_position), alternative_index)
				print("Set tile at ", tile_position, " to alternative index ", alternative_index)
			else:
				print("No tile found at position ", tile_position)
      GST2            ����                        �  RIFF�  WEBPVP8L�  /��?�0h�H���{�;1~��ʠk�HNؙ���k۶�َ�[Wf�/p�N��@& ��Q�"������������%7���N�������W��-�_��O�������l�ֶ�W� =Q�)s��ϊ��e�.oPn�D2 �ضU7+�eRfffffVPCuR%���H�$I.C�\�k��_ ��mU�i�<�!.��q����Y���֦(�;)�dS�R�;l��J�S�����$�6�����'�����l���߁�6��d������%ٶ��k�#�֐PÈ��2{R/�d^�w*�<�=!5	��ݣP���f����M���KW` �ԧ5L�a�ӓc�Y*:���t]�.QH�l[����L8f���	8���y��bf��z����#�ކ$��Z{����g0�]�b��#�9�9眳�p���n�l1~v+�䶑$����Z���L=A�m�mۜ?��33MJq�n3k]��%A�(�2�5��H�#I�^T谚���`u�4:��@~d7����ꏕH��J0T�/^��\���p���܀��v�F����a�)�l�9�j��m��l��$I��Ƴ�.c� � ������_����=��M�{�#�i�ĀP���?
B���n? �������w�#0���~���r�k�������Ӕ�T
K��leդ���lHx�Nx�NxK3�T%LU�t�ӈp�W�p��4!l�V!-6��&�DZ,Hx@�"F�� ;
������ѐ�Ѱ�0U��
"V=*3*3-^	i"!M�ł�$< �T;J��$+JN*-9ђ-���ld#f���0��0��T8z��������Q�t-E�?���e�iٴ�a���a���DD�ꪺ�\U����R��Z.����ӟjF�RQ�T���T2ږ��e�m#n��[$��
@��
F���}?G �J�M��!-�[�?4���������\1���('��魜�x�CJ�-��&Voٵ��&��ޢ���U�D��[34<@x�Q�b".�ފi���=���r�h2 �a��[k�Z"��-��O��JDzk���0* QJ�E��R��N"��[&ӟ����������j$�J����'�_v>R�5R�%(t�zP���Zoz�?-�����&�� �b�H��!U�M][!3��M����Q�޴���[/s7^���^���^�n=��z	�{�������O2���?}���P�`3�&��#��#�џ�(" ����!	d��: �݀Vπ�s��K��P%���n@O�|�P@�g�rH���s���3 C�[��������}g? �����nC�=Ax�t�x.{���C�������rA/��y9g����oO��w\0�d��m�y�;\& �_�;ŀr1m�.�Cr̷'ls>�\���=v��;f2ߞ���}��导��v���H ������6/�æК���i�}w�oO�l@] �N�̷�6 ����6��t@����haу�KpA�#�e���0(�'p�ݎ"0�h��~�~Jr�H��s�o�H���m,z`��KL%z�~>�v�n�9θ�c�!����\�_2�ܢ�do��ms�9�b:7ଙ���bd���������Knn��=�&�9��3��ls��tn���S	؛ı� 7  ��-c\5�5�dXo�" "����3Yσ,��Ҁc�#�-���6��\5�5��p�{O�F�s#L0� ʟy��TrAK��������\5�j�j�U]�U��sӧs�ӹ��z^���D���c�&��\5w��U3WM�^�&7�oM��6�z!&b"O��3�9<�3J�j_]�p�80�T�U]�ͬ҆��]�KO?�d=�w�����X
0hb�������+�JJ����_{6ɕ�ٛ���[ƭ��7ǧ8#6��U���3����=���J�\�)��������U]�$BT���p�7�:�s��fh\��U0C�- {"�W�^�W�$��)�������� "���a��ڋ�/��?���� �~�1�n�`@
PB0���R���W�3�?}~�_��ή_��ǟ��t�Rlj~��bH�Y߿�n���zL��J��!���*V���������m���?|x�������|����u�j��P��@7q�%(bH�8�!�_�~����Fd�sw�_�~��fN7?����;��Uv/��"���l�n��V�"^�kP�A�_U~U��D�;���m^�3��[~����fNb>������6Q�{��(Q��ԓ�uؤ�}S �?O�U�~�Stъ��J���:M�Wb��=n}�͝�_v��S2%�Ǔ��v}��������)�� ,�"*�=��⟟�]��.J؍�_j\����^�meW*JYI�fܾ�<�� �<�W�~>����Q�ƺ�"*.h��yܽ�e�t��v���$B �S���w����b���n�c�R���,�T�����#$,d��}���ۭ^�8\d��Q�O�9�k7?�ǅ{���k?��X�����m��<Y�^��#l���������ޯ���~�ܯ�BB�"7�=ۼ�j��{��~���l3N]}1r�ờ�|��V>>RæȵA�zR*a?�I���H������^����i+S�R�t��i��x{L1��'j�R?>*A �4����<�w%��Nd��k���I��B��l���_�����������q�ʵ�k����Ej�V�l��bHZ�c	؛�c�Y��j%���gV"̧����W�uw䚏�@��B|K�Kmt��5�}�[�3���&�I7i�0/�T���!W�A	�C�ar��G�2���l�1��Vy����)̩]��ʾsg.�]��KI�z=0�%��3���Ȟə���G�ʫ��n��yݝ��Y�����J��n�,�N��e[v��+����E?~� ��G	����ۭ]�g)T�Rf����m�\�'�C�����"rgȝ�\��C����@o��A�9���v'Nk9Nk:���Ya��_�����	̝�.g�æDo�R����$���y��+������V?��G���.w�/w���r9�]�v�{c<�>+���{^;_�#��
��N��( ��
�|�W���v�ԍ��pA-����ajڈ���T_.�n��Z�8�g L��,���^۬t�,�.�fK5H�-�� L}X��l�m.g3+һ�;��b�n`Y_.!�l0\����0;`;�M�޾F�h������/:� pX�>M���aS7�qzq��-]�� ��}�G�ȇ���c"���\P��BY�*�������=�;��%=�.���e����&g?��9�D��ߛ�=��3 f��z����>���- dx�#�9�%�~������-�G�۟h����������w�	֛����K���K<��~��3^{���]��GW=nG�=�l}l}�a7�|R0��@���ǜ��z�����G Л8x��	�ߝãw�w�, �ӻV�4�*�al < ���s��sv\e	ջVQCO���'e3\� YB�0�񑋸v�.��8�4xAs�p����39��<�{���EH���~�o��1 U���� = )NG8�t�T����:I��D�7��ױn8�{g9?&�����V#��q򝎓�q��$�Χ 3+��_������~��u��n8�ƺA�n������qRt�����q�(���q����0���gg}tvV;;�2�͡ ��{7�+MQ��T��D
�����Л��W\�}���բ�����XB�n����A
π���_��GdD��MV�٤����N#SDۿH�_O�8��쬇�d�g�"^�{��&ͤ�L&��b:��ŏ:���j��n$;(���%�"�h��qɱ�x���-F�y2q�\@��f�a�罋�����:�e��w�}֨ht��j�4L��s�����}�a�1�6��l��0̆2���(���W����0� @K����h�z4�Ѩa��0* @�n����D\�3p�A �� �<�h\��Ge �t�{j3��0<����]�_��)n�"BD1�����}+���<T�d��vkm�ֻ�N����{ۥm��]ދ�C�=R�t)����ѹ�0	���Qa���=�~W���#M#�C���+׻W�w��U^ &��J�8ĳ�Z�w�]�^�޽^P����v����0=纝�"�V�+9�K��G�{���[q\�pD�	0y���8�!J	� =z�����-��RL[�  ����W�E.�
�H�N��D��fK��un�xD^ &�A�6OJ Pǀ�1��j�DX
� KY�ºֽ��# �i��i�O�,��^��uԭ�no�z�j�Gj5�i�M�O�ſ<������阦cVo��꽪_�Ʊ�`�"� ��^ &�����h����wM'��ɩvr�g�z����֋��T`
  J�^���T��|�X/�׋�^�zl��� L@�c h��F\!���z�E�j�+2�{��{�~/H�nlQ���@l�g��8!�z �% �~/�����,�^���I�^��bg��x�̮�]e�����I��E�Ӻ���Q��79��d�ӅFﰔ;a)�����	����h��d�Ӻ��z��ha��R��a)���R�  �Y/ �@]Ou=�̫�«�«�bJ���HX���0,%��`�3P���7   ���z���u;��`X
�R�Pf�	ϢA� ��Z,Pc����G�O���������q�a�Q@�u��?r|�~������_n����v��Χ��ێ���������W�צں�֦Z���Y�t���u��-0 �lx��'Y鎦�M=z�l��6���6�st;�Ɵ�  �'Y�y�l�E�� TK��`��E�qy\,�� @����~����������v>�����_kױvp���^Z��;��� �����u��r ��� �`�A�;K�%�8M��4Np�`��@� 
$������l��
��	��{��'��v6>Ӯ���6O������K�+O��O��O��j�K�+tyxҵ�'��Ͱ��������{g-R�-�E���	����f5*�n�8�%q�+HP�˒ݒ���m�&m܍{�@�+0�E�?5�W���~A��#.����K�̲��]��gh3hw�v7tq����8����n�͠�}kW����nي�ɪT�|TR>5��jt1�Kt�� -IK��f��l�͘�� �88�S�f۴����/Ċ�gCW*]��,�?�e��ط{1�dY�tK����ӝ��Ĥ+e%S�Q�O�N�D]�8�+� Ò���6� 
����]Q� /%S�J��JŰ����Ŧ����V����E\{���r+̤)��*���n��NE�%�|���c��IӘ�0�я���_�r��Q�����1=�EI�TI��Of��<6y"����I7��2bCl���i+Ԥ(�K�n������ˎ�ξzƏ�=e��MYA�5������D%)'դ�&�M��jb�fRM��"V��iM�tJP�㷙���rT�
J�_ �&�"{���8�����$�IIMlUL�IQ"b�P Dpw�lk%�K�4�����D����$M�!F� �����O3                [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bpxx1jgso5tt1"
path="res://.godot/imported/hex_grid.png-3c8ae0c01c0cb53179044f008dbae01f.ctex"
metadata={
"vram_texture": false
}
            GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://itigiajjetj1"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 GST2   G   D      ����               G D        T  RIFFL  WEBPVP8L?  /F� ���$��m��x�3	�m#I�o����ȃ'5m#I�o�)���gw����n��wY Ϥ�,�E   �D��.�ojF����qgܡd��lۊ�����so� Q��?M�Z������a����.�b^��i�4��t��H�(�7*�$h���!\������=C^����d@W� i��K������4f7��(萛Ҙ�D���at��E��5�\�({17@�E�"o`�F�K�C���\�%ߨz�\��#V~��9��P�b�Շ[��]��!t:���s�%,5ŝ��#��%w�h�(���Cczr �D����xJ',����#�J��}� �(h��`iP��j*D�)[��F:-��P�� z���-������N@h�\�\�@4r9T���}�ѥ���Ø���K��v�����=���U�n@8��e��
Hq��l���ڇa�/  ,¯�b[V����fIM�x�BA�6�e��@&U �nE��a�@��2o�n<��
�tS�gzK�2s�}��$ ~ /2�R2{,�_��     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dfe1hyeoodcc0"
path="res://.godot/imported/Nimetön.png-b84a16d0c6a211d1f077f241fd503bd4.ctex"
metadata={
"vram_texture": false
}
            [remap]

path="res://.godot/exported/133200997/export-33e29fa2f2bb68ceed4cd1a3a579b7ea-Fighter.scn"
            [remap]

path="res://.godot/exported/133200997/export-76b8bc62749e8cf48c832874a4449e21-Level1.scn"
             list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              ��9 X   res://icon.svg�e*[��*   res://Levels/Level1.tscn|�Bj�~h0   res://hex_grid.png���
C�\h   res://Nimetön.png?8�}��A   res://Fighters/Fighter.tscn�ʐC��P   res://Fighters/Fighter.tscn`J�%   res://Fighters/Fighter.tscn             ECFG      application/config/name         Fighter Escort     application/run/main_scene          res://Levels/Level1.tscn   application/config/features   "         4.2    Mobile     application/config/icon         res://icon.svg  #   rendering/renderer/rendering_method         mobile                