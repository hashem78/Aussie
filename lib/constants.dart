import 'package:Aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

const kausBlue = Color(0xFF0052B4);
const kausRed = Color(0xFFD80027);
const kaussieRadius = const BorderRadius.all(Radius.circular(20));
String kurl =
    'https://via.placeholder.com/200/${getRandomColor().toString().substring(10, 16)}/FFFFFF';
const String klorem =
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam egestas velit vitae enim maximus, vitae pulvinar ligula interdum. Quisque vitae neque efficitur sem condimentum viverra at sed justo. Etiam auctor mattis odio in porta. Quisque eget risus ut felis imperdiet vulputate. Sed cursus ut dui viverra auctor. Nunc venenatis vel neque ut cursus. Aenean ornare eu quam at aliquam.

Nulla imperdiet lacus at enim consectetur consequat. Donec dapibus est sed lacinia placerat. Vestibulum varius massa lorem, eget mattis purus dapibus ut. Donec in augue et nisi viverra laoreet. Ut interdum leo sed dictum consectetur. Proin lacinia ex sit amet turpis blandit, nec euismod mi dictum. Integer nec volutpat ipsum. Maecenas mauris turpis, viverra at ullamcorper id, eleifend in mauris. Suspendisse pretium urna eget pellentesque tristique. Cras facilisis metus et vehicula mollis. Nulla ut placerat ipsum, vel suscipit lectus. Suspendisse potenti. Suspendisse et magna eu mauris sodales consectetur non eget est. Vestibulum vel finibus augue, quis pulvinar dui.

Vivamus at sollicitudin mi, a vehicula massa. Nullam metus metus, egestas nec sollicitudin et, congue sed nisi. Nulla fermentum nunc vel metus molestie consectetur. Vivamus eu lectus consectetur, vulputate augue sit amet, bibendum sem. Donec eget odio elementum, interdum eros eu, consectetur orci. Duis eu iaculis quam. Sed ultricies sapien eu felis sollicitudin imperdiet. Cras ullamcorper feugiat diam in luctus. Pellentesque dignissim ultrices quam, ac commodo nisi ullamcorper non.

Donec eget molestie erat. Nunc at condimentum risus. Suspendisse sit amet metus sem. Donec feugiat, odio eget vestibulum efficitur, sem justo posuere libero, in mollis diam risus a ex. Phasellus volutpat, magna ac maximus tristique, ipsum enim congue ipsum, a imperdiet sem orci vel velit. Mauris porta erat ex, eu congue velit ullamcorper sed. Nunc eu massa sapien. Nulla in rutrum orci. Suspendisse potenti.

Sed posuere viverra maximus. Morbi efficitur ultrices sem in consequat. Pellentesque vehicula dui at viverra molestie. Sed at dolor a neque dictum rutrum. Cras posuere velit non cursus tempus. Aenean convallis dictum erat eget mollis. Nam fermentum condimentum purus. Pellentesque lacinia hendrerit hendrerit. Integer eget quam consequat diam efficitur suscipit non facilisis tellus. Vestibulum in nibh eget enim hendrerit convallis at interdum quam. Phasellus dictum tortor lacus, blandit dictum erat dictum ut. Sed a tincidunt mi. Mauris tortor tellus, tristique et mi vitae, interdum porttitor ex. Fusce vestibulum, nisi in convallis eleifend, sem arcu facilisis risus, pulvinar vehicula lorem nibh in magna.

Vestibulum elementum sodales ullamcorper. Quisque ullamcorper, velit vel volutpat tincidunt, turpis ex laoreet ligula, et vulputate augue justo sit amet mauris. Aenean ac ipsum aliquet ipsum ullamcorper gravida quis ac libero. Vivamus vulputate sagittis nulla, non ornare urna laoreet sit amet. In venenatis arcu at erat elementum tincidunt. In nec magna consectetur, consequat augue ornare, blandit ipsum. Vestibulum aliquam, libero quis tristique malesuada, est felis congue ipsum, nec gravida mauris tortor tincidunt metus. Etiam condimentum, ipsum eget aliquam luctus, tortor libero euismod lacus, at tempus erat nibh eu turpis. Mauris pharetra elit vel nunc egestas, consectetur pharetra tellus ultrices. Duis semper, sem non luctus imperdiet, tellus nulla efficitur orci, sit amet sollicitudin ante massa varius tortor. Suspendisse ac sapien ipsum.

Cras interdum odio tortor, rutrum tempus sapien pharetra et. Donec efficitur justo dapibus velit porttitor, sit amet feugiat justo vehicula. In dictum fermentum erat vel ultricies. Duis laoreet euismod quam nec efficitur. Nam venenatis sed orci at interdum. Nam nisi diam, vestibulum sed enim ac, blandit porttitor dui. Fusce metus felis, dapibus eget lacus sed, laoreet accumsan elit. Phasellus nec ante semper, facilisis ipsum id, congue dui.''';

var g = Colors.green;
