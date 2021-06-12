<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * This file contains the list of course modules along with cmid.
 *
 * @package    block_moodletest
 * @copyright  2021 Pinky Sharma
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

defined('MOODLE_INTERNAL') || die();
require_once($CFG->libdir . '/filelib.php');

class block_moodletest extends block_list {
    public function init() {
        $this->title = get_string('pluginname', 'block_moodletest');
    }

    public function get_content() {
        global $CFG, $DB, $OUTPUT;

        if ($this->content !== null) {
            return $this->content;
        }

        $this->content = new stdClass;
        $this->content->items = array();
        $this->content->icons = array();
        $this->content->footer = '';

        $course = $this->page->course;

        require_once($CFG->dirroot.'/course/lib.php');

        $modinfo = get_fast_modinfo($course);
        $modfullnames = array();
        $moddetail = array();

        $archetypes = array();

        foreach ($modinfo->cms as $cm) {
            // Exclude activities that aren't visible or have no view link.
            if (!$cm->uservisible || !$cm->has_view()) {
                continue;
            }
            if (array_key_exists($cm->id, $moddetail)) {
                continue;
            }
            $moddate = userdate($cm->added, get_string('strftimedatemod', 'block_moodletest'));
            $this->content->items[] = '<a href="'.$CFG->wwwroot.'/mod/'.$cm->modname.'/view.php?id='.$cm->id.'">'
                    .$cm->id. ' - '. $cm->name.' - '.$moddate.'</a>';
        }

        return $this->content;
    }

    /**
     * Returns the role that best describes this blocks contents.
     *
     * This returns 'navigation' as the blocks contents is a list of links to activities and resources.
     *
     * @return string 'navigation'
     */
    public function get_aria_role() {
        return 'navigation';
    }

    public function applicable_formats() {
        return array('all' => true, 'mod' => false, 'my' => false, 'admin' => false,
                     'tag' => false);
    }
}


