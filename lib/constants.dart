import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

const kausBlue = Color(0xFF00008b);
const kausRed = Color(0xFFD80027);
const kaussieRadius = const BorderRadius.all(Radius.circular(20));
String kurl =
    'https://via.placeholder.com/500/${getRandomColor().toString().substring(10, 16)}/FFFFFF';
const String klorem =
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam egestas velit vitae enim maximus, vitae pulvinar ligula interdum. Quisque vitae neque efficitur sem condimentum viverra at sed justo. Etiam auctor mattis odio in porta. Quisque eget risus ut felis imperdiet vulputate. Sed cursus ut dui viverra auctor. Nunc venenatis vel neque ut cursus. Aenean ornare eu quam at aliquam.

Nulla imperdiet lacus at enim consectetur consequat. Donec dapibus est sed lacinia placerat. Vestibulum varius massa lorem, eget mattis purus dapibus ut. Donec in augue et nisi viverra laoreet. Ut interdum leo sed dictum consectetur. Proin lacinia ex sit amet turpis blandit, nec euismod mi dictum. Integer nec volutpat ipsum. Maecenas mauris turpis, viverra at ullamcorper id, eleifend in mauris. Suspendisse pretium urna eget pellentesque tristique. Cras facilisis metus et vehicula mollis. Nulla ut placerat ipsum, vel suscipit lectus. Suspendisse potenti. Suspendisse et magna eu mauris sodales consectetur non eget est. Vestibulum vel finibus augue, quis pulvinar dui.

Vivamus at sollicitudin mi, a vehicula massa. Nullam metus metus, egestas nec sollicitudin et, congue sed nisi. Nulla fermentum nunc vel metus molestie consectetur. Vivamus eu lectus consectetur, vulputate augue sit amet, bibendum sem. Donec eget odio elementum, interdum eros eu, consectetur orci. Duis eu iaculis quam. Sed ultricies sapien eu felis sollicitudin imperdiet. Cras ullamcorper feugiat diam in luctus. Pellentesque dignissim ultrices quam, ac commodo nisi ullamcorper non.

Donec eget molestie erat. Nunc at condimentum risus. Suspendisse sit amet metus sem. Donec feugiat, odio eget vestibulum efficitur, sem justo posuere libero, in mollis diam risus a ex. Phasellus volutpat, magna ac maximus tristique, ipsum enim congue ipsum, a imperdiet sem orci vel velit. Mauris porta erat ex, eu congue velit ullamcorper sed. Nunc eu massa sapien. Nulla in rutrum orci. Suspendisse potenti.

Sed posuere viverra maximus. Morbi efficitur ultrices sem in consequat. Pellentesque vehicula dui at viverra molestie. Sed at dolor a neque dictum rutrum. Cras posuere velit non cursus tempus. Aenean convallis dictum erat eget mollis. Nam fermentum condimentum purus. Pellentesque lacinia hendrerit hendrerit. Integer eget quam consequat diam efficitur suscipit non facilisis tellus. Vestibulum in nibh eget enim hendrerit convallis at interdum quam. Phasellus dictum tortor lacus, blandit dictum erat dictum ut. Sed a tincidunt mi. Mauris tortor tellus, tristique et mi vitae, interdum porttitor ex. Fusce vestibulum, nisi in convallis eleifend, sem arcu facilisis risus, pulvinar vehicula lorem nibh in magna.

Vestibulum elementum sodales ullamcorper. Quisque ullamcorper, velit vel volutpat tincidunt, turpis ex laoreet ligula, et vulputate augue justo sit amet mauris. Aenean ac ipsum aliquet ipsum ullamcorper gravida quis ac libero. Vivamus vulputate sagittis nulla, non ornare urna laoreet sit amet. In venenatis arcu at erat elementum tincidunt. In nec magna consectetur, consequat augue ornare, blandit ipsum. Vestibulum aliquam, libero quis tristique malesuada, est felis congue ipsum, nec gravida mauris tortor tincidunt metus. Etiam condimentum, ipsum eget aliquam luctus, tortor libero euismod lacus, at tempus erat nibh eu turpis. Mauris pharetra elit vel nunc egestas, consectetur pharetra tellus ultrices. Duis semper, sem non luctus imperdiet, tellus nulla efficitur orci, sit amet sollicitudin ante massa varius tortor. Suspendisse ac sapien ipsum.

Cras interdum odio tortor, rutrum tempus sapien pharetra et. Donec efficitur justo dapibus velit porttitor, sit amet feugiat justo vehicula. In dictum fermentum erat vel ultricies. Duis laoreet euismod quam nec efficitur. Nam venenatis sed orci at interdum. Nam nisi diam, vestibulum sed enim ac, blandit porttitor dui. Fusce metus felis, dapibus eget lacus sed, laoreet accumsan elit. Phasellus nec ante semper, facilisis ipsum id, congue dui.''';

const String c3no = '''
The Australian red meat and livestock industry has set the ambitious target to be Carbon Neutral by 2030 (CN30).

What does CN30 mean?
This target means that by 2030, Australian beef, lamb and goat production, including lot feeding and meat processing, will make no net release of greenhouse gas (GHG) emissions into the atmosphere.

With a commitment from all of industry, the right policy settings and ongoing research investment, the Australian red meat industry can be at the forefront of carbon neutrality.

The CN30 target sends a clear signal to government and consumers that the red meat and livestock industry is proactively addressing emissions and taking action to improve long-term productivity while striving to deliver zero net emissions.

Why is it important?
Staying ahead of current and future consumer, customer and community expectations regarding environmental credentials allows red meat producers to stamp their mark in a competitive global protein market.

Demonstrated commitment to environmental stewardship, through initiatives such as CN30, enables ongoing trust and support for the red meat and livestock industry. It underpins Australia’s position as a responsible producer of high value, clean, safe and natural protein.

What will this mean for Australia’s national livestock numbers?
Carbon neutrality doesn’t need to come at the cost of livestock numbers.

CSIRO analysis shows it’s possible to achieve CN30 without reducing herd and flock numbers below the rolling 10 year average (25 million cattle, 70 million sheep and 0.5 million goats).

By 2030, producers will be even more attuned to the influence of genetic, environmental, technological and market factors on red meat production, and will be able to:

access the best information, enabling selection of livestock with multiple attributes to increase productivity and reduce methane emissions per kilogram produced
select supplements, pastures, legumes and trees with multiple attributes, enabling livestock to thrive in more extreme weather and climate conditions
access more established markets for low and zero carbon red meat and co-products.

What is being done?
MLA has developed the following areas of work, to deliver outputs which are required for industry to achieve CN30:

GHG emissions avoidance activities on-farm, feedlots and processing.
Carbon storage on-farm via trees, legumes and pastures.
Integrated management systems linking GHG emissions avoidance and carbon storage activities into farm system thinking.
Leadership building to support growth in capacity and competency among individuals and organisations.

''';
const String livestockDescription = '''
The livestock export industry is a valuable Australian industry that was valued at over 780 million for the 2015-16 financial year and supports the livelihood of many people in rural and regional Australia.

The Australian Government has a responsibility to all those involved in the export of livestock. This includes livestock producers, exporters and support industries such as transport that rely on livestock exports for their income, and the broader Australian community that relies on the Australian Government to enforce standards that reflect their values, including protecting the welfare of exported animals.

The Department of Agriculture, Water and the Environment regulates the export livestock industry. Livestock exporters must meet high animal welfare standards through regulations such as those that underpin the Exporter Supply Chain Assurance System (ESCAS).

The introduction in July 2011 of ESCAS, first for export of feeder and slaughter cattle to Indonesia, and later extended to all feeder and slaughter livestock to all destinations, was a significant reform for the livestock export industry. ESCAS gives transparency and accountability to how exported livestock are treated, starting from the farm, and extending to slaughter in the importing country. ESCAS is also a system that can identify where a problem exists, and address it directly.

The introduction of ESCAS means that Australia’s commitment to the humane treatment of its exported livestock does not stop the moment they are unloaded from an export vessel. Australia is the only country of more than 100 countries that export livestock that requires its exporters to achieve specific animal welfare outcomes for exported livestock in the importing country.

Australia has exported more than 10 million livestock under ESCAS since October 2013, including almost two million sheep during 2015–16.

Livestock exporters must also comply with the Australian Standards for the Export of Livestock.

The Australian Government has memorandums of understanding (MoUs) with a number of countries in the Middle East and Africa, and negotiations continue with other trading partners. MoUs reinforce importing country commitment to international animal welfare standards and provide government-to-government assurances that Australian livestock will be unloaded on arrival, regardless of the results of initial animal health inspection.

The department’s work also means that Australia is a global leader in animal welfare. The ‘Australian position statement on the export of livestock’ sets out guiding principles and minimum recommended animal health and welfare outcomes for animals in the export livestock industry, consistent with international animal welfare standards (OIE). Australia is an active member of the World Organisation for Animal Health (OIE) and strongly supports OIE activities on animal welfare.

The Australian Meat and Live-stock Industry Act 1997 requires that the department send a report to parliament every six months on mortalities for livestock exported by sea. These reports show that voyage mortality rates have fallen considerably since the year 2000.

History of the trade and reviews​

The Australian Government has a responsibility to ensure that exporters maintain high standards of animal welfare throughout the export chain, for the sake of the exported livestock, and for the sake of the farmers, exporters and communities who rely on livestock exports for their livelihood.

The department also plays a wider policy role in the export livestock industry by regularly undertaking policy reviews and driving improvements.

The department supports the export livestock industry to achieve high standards of animal welfare. Our work helps provide long-term stability for the industry and its workers.

The department's international work in the export of livestock is vital. We engage with overseas governments to negotiate memorandums of understanding and facilitate trade within a framework of high standards of animal welfare.
''';

const heducation =
    '''                  Higher education courses can be taken to earn an advanced degree and continue your studies in Australia. There are three main types of higher education which lead to Bachelor, Master and Doctoral Degrees.

In Australia it is quite common for students to enrol in a double or combined Bachelor Degree program which leads to the award of two Bachelor Degrees. This is most common in the fields of arts, commerce, law and science.

Australian institutions offer a wide range of courses – from science to management and commerce, humanities to engineering, and law to health sciences. Australian institutions rank among the world’s best by discipline, particularly in engineering and technology, medicine, environmental science, and accounting and finance.

There are 43 universities in Australia (40 Australian universities, two international universities, and one private specialty university). Along with our universities, many other institutions offer higher education courses. You can search for institutions and courses using the Institution and Course Search on this website.

Our quality assurance
Australia has a national regulatory and quality agency for higher education – the Tertiary Education Quality and Standards Agency (TEQSA). It was established by the Australian Government to monitor quality, and regulate university and non-university higher education providers against a set of standards developed by the independent Higher Education Standards Panel.

In addition, the following student rights are protected by law under the Education Services for Overseas Students (ESOS):

The well-being of all international students.
The quality of students' education experience.
The provision of up-to-date and accurate information.''';
