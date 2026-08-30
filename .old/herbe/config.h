static const char *background_color = "#121212";
static const char *border_color = "#9d0006";
static const char *font_color = "#b57f14";
static const char *font_pattern = "Cascadia Code:size=10";
static const unsigned line_spacing = 5;
static const unsigned int padding = 15;

static const unsigned int width = 450;
static const unsigned int border_size = 2;
static const unsigned int pos_x = 30;
static const unsigned int pos_y = 60;

enum corners { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT };
enum corners corner = TOP_RIGHT;

static const unsigned int duration = 60; /* in seconds */
static const int use_primary_monitor = 1;

#define DISMISS_BUTTON Button1
#define ACTION_BUTTON Button3
