import "bootstrap";

import {searchType} from '../component/search_type'
import {dropdown} from '../component/dropdown'

import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/init_mapbox';

initMapbox();
